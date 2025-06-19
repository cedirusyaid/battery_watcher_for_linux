# 🔋 Monitor Power Notifier

Script bash sederhana untuk memantau status baterai pada sistem Linux dan mengirim notifikasi ke Telegram **jika baterai di bawah 40%**. Cocok digunakan pada laptop yang sering digunakan secara mobile agar tidak kehabisan daya mendadak.

---

## 📦 Fitur

✅ Menggunakan `upower` untuk membaca status baterai  
✅ Mengirim notifikasi ke Telegram menggunakan Bot  
✅ Menampilkan 5 proses yang paling banyak memakai memori  
✅ Hanya mengirim notifikasi jika baterai di bawah 40%  
✅ Mendukung output dengan format HTML Telegram  
✅ Bisa dijadwalkan via cron setiap 2 jam (atau sesuai kebutuhan)

---

## 🖥️ Contoh Output Telegram

```
📡 Baterai Rendah!
🖥️ Hostname: cd-nt
👤 User login: cedi
📂 Proses Aktif:
58685 chrome       7.9
4447  chrome       4.0
89736 Telegram     3.2
58645 chrome       3.0
3728  gnome-shell  2.8
📅 Waktu: 2025-06-19 10:10:00
🔋 Status: discharging
🔋 Kapasitas: 21.669 / 26.1 Wh (83%)
⚙️ Konsumsi: 8.232 W
⚡️ Perkiraan waktu tersisa: 2.63 jam
```

---

## 📄 Instalasi

1. **Clone repo ini**
   ```bash
   git clone https://github.com/namakamu/monitor-power-notifier.git
   cd monitor-power-notifier
   ```

2. **Buat file `.env`**
   Di direktori utama project, buat file `.env`:
   ```env
   BOT_TOKEN=123456789:ABCdefGhIJKlmNoPQRstuVWXyz
   CHAT_ID=-1234567890123
   ```

3. **Jalankan secara manual untuk pengujian**
   ```bash
   chmod +x monitor_power.sh
   ./monitor_power.sh
   ```

---

## 🕒 Jadwalkan dengan Cron

Untuk mengirim otomatis setiap 2 jam:

```bash
crontab -e
```

Tambahkan baris berikut:

```
0 */2 * * * /path/to/monitor_power.sh
```

---

## 📜 Isi Script

Lihat versi script terbaru di file [`monitor_power.sh`](./monitor_power.sh)  
Atau salin langsung dari dokumentasi [di sini](#-shell-script-monitor_powersh)

---

## ⚙️ Dependensi

- `bash`
- `upower`
- `ps`, `grep`, `awk`, `bc`, `curl`
- Akun Telegram dan Bot dengan akses ke grup atau ID tujuan

---

## 📜 License

MIT License – bebas digunakan, diedit, dan dibagikan.

---

## 💬 Kontribusi

Pull Request dan Issue sangat diterima!  
Silakan bantu menambahkan fitur seperti:
- Notifikasi saat charging penuh
- Integrasi log ke file
- Kirim ke banyak grup sekaligus

---

## 👨‍💻 Developer

Made with ❤️ by Cedi Rusyaid
Telegram: [@yourtelegram](https://t.me/cedirusyaid)
