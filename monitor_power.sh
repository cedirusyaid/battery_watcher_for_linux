#!/bin/bash
 
# === Load konfigurasi dari .env ===
ENV_FILE="$(dirname "$0")/.env"
if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' "$ENV_FILE" | xargs)
else
    echo "File .env tidak ditemukan!"
    exit 1
fi

# === Informasi sistem ===
HSNAME=$(hostname)
LOGIN_USER=$(whoami)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# === Dapatkan status baterai ===
BAT_PATH=$(upower -e | grep BAT)
INFO=$(upower -i "$BAT_PATH")

STATUS=$(echo "$INFO" | grep "state" | awk '{print $2}')
ENERGY_NOW=$(echo "$INFO" | grep "energy:" | awk '{print $2}')
ENERGY_FULL=$(echo "$INFO" | grep "energy-full:" | awk '{print $2}')
POWER_NOW=$(echo "$INFO" | grep -E 'energy-rate:|power:' | head -n1 | awk '{print $2}')
PERCENT=$(echo "$INFO" | grep "percentage:" | awk '{print $2}' | tr -d '%')

# === Keluar jika baterai di atas atau sama dengan 40% ===
if [ "$PERCENT" -ge 40 ]; then
    echo "ℹ️ Baterai $PERCENT% — tidak dikirim ke Telegram karena di atas 40%"
    exit 0
fi

# === Hitung waktu pemakaian (jika tidak charging) ===
if [[ "$STATUS" = "discharging" && "$POWER_NOW" != "" && "$POWER_NOW" != "0" ]]; then
    TIME_REMAIN=$(echo "scale=2; $ENERGY_NOW / $POWER_NOW" | bc 2>/dev/null)
    TIME_MSG="⚡️ Perkiraan waktu tersisa: $TIME_REMAIN jam"
elif [ "$STATUS" = "discharging" ]; then
    TIME_MSG="⚠️ Tidak bisa menghitung waktu pemakaian"
else
    TIME_MSG="🔌 Laptop sedang terhubung ke charger"
fi

# === Ambil 5 proses terbesar berdasarkan penggunaan memori ===
TOP_PROCESSES=$(ps -u "$LOGIN_USER" --sort=-%mem -o pid,comm,%mem --no-headers | head -n 5)
PROCESS_LIST="<b>📂 Proses Aktif:</b><pre>$TOP_PROCESSES</pre>"

# === Format pesan dalam HTML ===
MESSAGE="📡 <b>#BateraiRendah!</b>
🖥️ <b>Hostname:</b> $HSNAME
👤 <b>User login:</b> $LOGIN_USER
$PROCESS_LIST
📅 <b>Waktu:</b> $DATE
🔋 <b>Status:</b> $STATUS
🔋 <b>Kapasitas:</b> $ENERGY_NOW / $ENERGY_FULL Wh ($PERCENT%)
⚙️ <b>Konsumsi:</b> ${POWER_NOW:-Tidak tersedia} W
$TIME_MSG"

# === Kirim pesan ke Telegram ===
RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$MESSAGE" \
  -d parse_mode="HTML")

echo "✅ Pesan dikirim ke Telegram. Response: $RESPONSE"
