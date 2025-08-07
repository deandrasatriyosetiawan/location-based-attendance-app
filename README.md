# Aplikasi Absensi Berbasis Lokasi (Skill Test)
Sebuah aplikasi Flutter sederhana untuk absensi kehadiran berbasis lokasi dan foto selfie. Proyek ini dibuat sebagai bagian dari skill test untuk posisi Fullstack Developer di PT Trimitra Putra Mandiri.

# Cara Menjalankan
Pastikan Anda sudah menginstal Flutter SDK pada environment Anda.

1. Clone Repository
git clone https://github.com/deandrasatriyosetiawan/location-based-attendance-app.git

2. Masuk ke Direktori Proyek
cd location_based_attendance_app

3. Install Dependencies
flutter pub get

4. Jalankan Aplikasi
flutter run

# Plugin yang Digunakan
Berikut adalah daftar plugin utama yang digunakan dalam pengembangan aplikasi ini, dikelompokkan berdasarkan fungsinya:

## State Management
- flutter_bloc / bloc: Untuk manajemen state aplikasi secara reaktif dan terstruktur.

## Penyimpanan Data (Data Storage)
- firebase_core, firebase_auth, cloud_firestore: Untuk implementasi fitur otentikasi dan penyimpanan data di cloud.
- sqflite & path_provider: Untuk implementasi database lokal (SQLite) sebagai alternatif penyimpanan.
- shared_preferences: Untuk menyimpan data sederhana seperti status login atau preferensi pengguna.

## Hardware & API
- geolocator: Untuk mendapatkan data lokasi (GPS) pengguna secara akurat.
- image_picker: Untuk mengakses kamera perangkat dan mengambil foto selfie.

## Utilitas (Utilities)
- equatable: Untuk mempermudah perbandingan objek, terutama pada state dan event BLoC.
- intl: Untuk melakukan format tanggal dan waktu agar mudah dibaca oleh pengguna.

# Catatan Khusus
- Konfigurasi Firebase: Jika menggunakan fungsionalitas Firebase, pastikan untuk menambahkan file google-services.json Anda sendiri ke dalam direktori android/app/. Tanpa file ini, koneksi ke Firebase akan gagal.
- Platform: Aplikasi ini diuji dan dibuat untuk platform Android, sesuai dengan instruksi pada soal tes.