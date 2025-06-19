<?php 

$token = 'YOUR_BOT_TOKEN';
$channel_username = '@nama_channel_anda'; // atau invite link privat, ubah jadi publik sementara
$message = 'Tes kirim pesan ke channel';
file_get_contents("https://api.telegram.org/bot$token/sendMessage?chat_id=$channel_username&text=" . urlencode($message));

?>