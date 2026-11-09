# TaskMate – Task Management App

## Deskripsi
TaskMate merupakan aplikasi manajemen tugas berbasis Flutter yang dirancang untuk membantu pengguna mengatur, memantau, dan mengelola aktivitas secara terstruktur. Aplikasi ini menyediakan dashboard, pengelolaan tugas, statistik, serta motivasi harian.

## Fitur Utama
1. **Dashboard** – Menampilkan ringkasan jumlah dan status tugas.
2. **Task Management** – Menampilkan daftar tugas.
3. **Add Task** – Menambahkan tugas baru.
4. **Edit Task** – Mengubah informasi tugas.
5. **Delete Task** – Menghapus tugas.
6. **Task Detail** – Menampilkan informasi lengkap tugas.
7. **Statistics** – Menampilkan statistik tugas berdasarkan status dan prioritas.
8. **Daily Motivation** – Menampilkan kutipan motivasi dari REST API.
9. **Responsive Interface** – Mendukung penyesuaian tampilan berdasarkan ukuran layar.

## Teknologi yang Digunakan
- Flutter
- Dart
- Supabase Database
- REST API DummyJSON
- HTTP Package
- Provider dan ChangeNotifier
- Git dan GitHub

## Arsitektur Project

```text
lib/
├── models/
│   ├── task_model.dart
│   └── quote_model.dart
├── providers/
│   └── task_provider.dart
├── repositories/
│   └── task_repository.dart
├── screens/
│   ├── home_screen.dart
│   ├── task_list_screen.dart
│   ├── task_detail_screen.dart
│   ├── statistics_screen.dart
│   └── profile_screen.dart
├── services/
│   ├── task_service.dart
│   └── quote_service.dart
├── widgets/
│   ├── quote_card.dart
│   └── task_form_dialog.dart
└── main.dart
```

## Backend dan Database
TaskMate menggunakan Supabase sebagai backend untuk menyimpan data tugas. Operasi database meliputi:
- Create: menambahkan tugas.
- Read: mengambil dan menampilkan tugas.
- Update: memperbarui tugas.
- Delete: menghapus tugas.

## REST API
Aplikasi menggunakan DummyJSON Quotes API untuk mengambil data kutipan motivasi harian. Data JSON diproses menggunakan model Dart dan ditampilkan pada dashboard.

API: https://dummyjson.com/quotes?limit=5

## State Management
Provider dengan ChangeNotifier digunakan untuk mengelola state aplikasi dan memperbarui tampilan ketika data tugas berubah.

## Cara Menjalankan Project
1. Clone repository.
2. Buka folder project.
3. Jalankan perintah `flutter pub get`.
4. Konfigurasikan URL dan publishable key Supabase.
5. Jalankan aplikasi dengan `flutter run`.

## Build APK

Jalankan perintah:

```bash
flutter build apk --release
```

File APK tersedia pada:

```text
build/app/outputs/flutter-apk/app-release.apk