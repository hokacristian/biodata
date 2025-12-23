# Persiapan Presentasi Project Biodata Della

## Daftar Isi
1. [Pertanyaan Konsep Dasar](#1-pertanyaan-konsep-dasar)
2. [Pertanyaan Teknis Flutter](#2-pertanyaan-teknis-flutter)
3. [Pertanyaan State Management](#3-pertanyaan-state-management)
4. [Pertanyaan UI/UX](#4-pertanyaan-uiux)
5. [Pertanyaan Data & Keamanan](#5-pertanyaan-data--keamanan)
6. [Pertanyaan Package & Library](#6-pertanyaan-package--library)
7. [Pertanyaan Platform & Deployment](#7-pertanyaan-platform--deployment)
8. [Pertanyaan Problem Solving](#8-pertanyaan-problem-solving)

---

## 1. Pertanyaan Konsep Dasar

### Q: Apa tujuan pembuatan aplikasi biodata ini?
**A:** Aplikasi ini bertujuan untuk menampilkan CV/biodata saya dalam format digital yang interaktif dan modern. Berbeda dengan CV berbentuk PDF atau kertas, aplikasi ini:
- Lebih menarik dan interaktif dengan UI yang responsive
- Bisa diakses melalui berbagai platform (mobile, web, desktop)
- Memudahkan update informasi
- Menunjukkan skill saya dalam mobile development

### Q: Kenapa memilih Flutter sebagai framework?
**A:** Saya memilih Flutter karena beberapa alasan:
1. **Cross-platform**: Dengan satu codebase bisa deploy ke Android, iOS, Web, Windows, Linux, dan macOS
2. **Hot Reload**: Mempercepat development karena bisa lihat perubahan langsung
3. **Performance**: Flutter compile ke native code, jadi performanya bagus
4. **Material Design**: Flutter punya widget library yang lengkap untuk membuat UI modern
5. **Dart Language**: Bahasa pemrograman yang mudah dipelajari dan mirip dengan Java/JavaScript

### Q: Jelaskan flow aplikasi dari awal sampai akhir
**A:** Flow aplikasi:
1. User membuka aplikasi → tampil **Login Screen**
2. User input email & password → validasi form
3. Jika valid → Toast notification "Login berhasil" → navigate ke **Home Screen**
4. Di Home Screen tampil CV lengkap dengan foto, biodata, pengalaman, pendidikan, skills, dll
5. User bisa klik tombol logout → muncul dialog konfirmasi
6. Jika confirm logout → Toast notification → kembali ke **Login Screen**
7. Dari Login Screen ada link "Register" untuk user yang belum punya akun

---

## 2. Pertanyaan Teknis Flutter

### Q: Jelaskan perbedaan StatelessWidget dan StatefulWidget!
**A:**
- **StatelessWidget**: Widget yang tidak memiliki state/data yang berubah. Sekali di-render, tidak akan berubah kecuali ada rebuild dari parent.
  - Contoh: `HomeScreen` (hanya menampilkan data CV yang statis)
  - Lebih ringan dan cepat karena tidak track perubahan state

- **StatefulWidget**: Widget yang memiliki state internal yang bisa berubah. Ketika state berubah, widget akan rebuild otomatis.
  - Contoh: `LoginScreen` (ada state untuk password visibility, form input, dll)
  - Punya method `setState()` untuk trigger rebuild
  - Memiliki lifecycle: `initState()`, `build()`, `dispose()`

### Q: Apa fungsi `GlobalKey<FormState>` di login screen?
**A:** `GlobalKey<FormState>` digunakan untuk:
- Mengakses state dari Form widget
- Melakukan validasi semua TextFormField di dalam Form sekaligus dengan `_formKey.currentState!.validate()`
- Menyimpan data form dengan `save()`
- Mereset form dengan `reset()`

Di kode saya (line 14 login_screen.dart), saya pakai untuk validasi form sebelum login.

### Q: Kenapa pakai `Navigator.pushReplacement` bukan `Navigator.push`?
**A:**
- `Navigator.push`: Menambah screen baru ke stack, user bisa back ke screen sebelumnya
- `Navigator.pushReplacement`: Replace screen current dengan screen baru, user TIDAK bisa back

Saya pakai `pushReplacement` di:
1. Login → Home: agar user tidak bisa back ke login setelah berhasil login
2. Logout → Login: agar user tidak bisa back ke home setelah logout

Ini untuk UX yang lebih baik dan mencegah akses tidak sah.

### Q: Jelaskan lifecycle widget StatefulWidget
**A:** Lifecycle StatefulWidget:
1. **Constructor**: Widget dibuat pertama kali
2. **initState()**: Dipanggil sekali saat widget pertama kali dibuat. Digunakan untuk inisialisasi data, controller, dll
3. **build()**: Dipanggil untuk render UI. Bisa dipanggil berkali-kali ketika ada perubahan state
4. **setState()**: Method untuk update state dan trigger rebuild
5. **dispose()**: Dipanggil saat widget dihapus dari tree. Digunakan untuk cleanup (dispose controller, cancel subscription, dll)

Contoh di login_screen.dart:
- Line 34-37: `dispose()` untuk cleanup TextEditingController agar tidak memory leak

### Q: Apa fungsi `MediaQuery.of(context).size`?
**A:** `MediaQuery.of(context).size` digunakan untuk mendapatkan ukuran layar device. Ini penting untuk membuat UI yang responsive.

Contoh di login_screen.dart line 42:
```dart
final size = MediaQuery.of(context).size;
```
Kemudian digunakan untuk:
- `size.width * 0.25`: Icon size 25% dari lebar layar
- `size.height * 0.02`: Spacing 2% dari tinggi layar
- Dll, sehingga UI akan menyesuaikan di berbagai ukuran layar

### Q: Apa itu Material Design 3?
**A:** Material Design 3 (Material You) adalah design system terbaru dari Google dengan fitur:
- Color scheme yang lebih dinamis dan customizable
- Komponen UI yang lebih modern dan accessible
- Support untuk dark mode yang lebih baik
- Adaptive design untuk berbagai platform

Di aplikasi saya (main.dart line 21):
```dart
useMaterial3: true
```
Ini mengaktifkan Material Design 3 untuk semua widget.

---

## 3. Pertanyaan State Management

### Q: Apa itu State Management?
**A:** State Management adalah cara mengatur dan mengelola data/state dalam aplikasi. State bisa berupa:
- User input
- Data dari API
- UI state (loading, error, success)
- Authentication state, dll

### Q: State management apa yang digunakan di aplikasi ini?
**A:** Aplikasi ini menggunakan **setState** (built-in Flutter state management) karena:
- Aplikasi masih sederhana dengan state yang tidak kompleks
- State hanya lokal di masing-masing screen
- Tidak ada sharing state antar screen yang kompleks

Contoh penggunaan setState di login_screen.dart line 118:
```dart
setState(() => _obscurePassword = !_obscurePassword)
```
Untuk toggle visibility password.

### Q: Kenapa tidak pakai state management lain seperti Provider, Bloc, atau Riverpod?
**A:** Untuk aplikasi sederhana seperti ini, setState sudah cukup. State management library lain diperlukan jika:
- Ada sharing state kompleks antar banyak screen
- Ada business logic yang kompleks
- Perlu separation of concern yang lebih baik
- Aplikasi berskala besar

Jika aplikasi ini dikembangkan lebih lanjut dengan fitur backend, authentication real, dll, baru akan saya pertimbangkan Provider atau Bloc.

---

## 4. Pertanyaan UI/UX

### Q: Kenapa pakai gradient background?
**A:** Gradient background (login_screen.dart line 49-53) digunakan untuk:
- Membuat tampilan lebih modern dan menarik
- Memberikan depth/kedalaman visual
- Color scheme yang konsisten dengan branding (biru navy)
- Meningkatkan estetika UI

### Q: Jelaskan konsep responsive design di aplikasi ini
**A:** Responsive design adalah desain yang menyesuaikan dengan berbagai ukuran layar. Implementasi di aplikasi saya:
1. **Relative sizing**: Menggunakan persentase dari screen size
   ```dart
   fontSize: size.width * 0.07  // 7% dari lebar layar
   padding: size.width * 0.08   // 8% dari lebar layar
   ```
2. **Flexible widgets**: `Expanded`, `Flexible`, `Wrap` agar content menyesuaikan
3. **SingleChildScrollView**: Agar content bisa scroll jika terlalu panjang
4. **MediaQuery**: Detect ukuran dan orientasi layar

### Q: Kenapa password field ada obscureText?
**A:** `obscureText: true` membuat teks password disembunyikan (ditampilkan sebagai bullet points) untuk:
- **Keamanan**: Orang lain tidak bisa lihat password saat user mengetik
- **Privacy**: Standar UX untuk password field
- **Toggle visibility**: Ada icon button untuk show/hide password (line 116-118)

### Q: Jelaskan color scheme yang digunakan
**A:** Color scheme aplikasi:
- **Primary**: `#1E3A5F` (Navy Blue) - untuk branding utama
- **Secondary**: `#2D5478` (Lighter Blue) - untuk gradient
- **Accent**: `#2E7D32` (Green) - untuk success state (toast, certificate chips)
- **Text**: White, `#5A7A9A` (Gray Blue) - untuk kontras
- **Background**: `#E8EEF4` (Light Blue Gray)

Warna dipilih untuk memberikan kesan profesional dan clean.

---

## 5. Pertanyaan Data & Keamanan

### Q: Data CV disimpan dimana?
**A:** Saat ini data CV disimpan **hardcoded** di file `lib/data/cv_data.dart` sebagai object `cvData`.

**Kelebihan:**
- Sederhana dan cepat untuk prototype
- Tidak perlu backend atau database
- Data langsung tersedia offline

**Kekurangan:**
- Tidak bisa update data tanpa rebuild aplikasi
- Tidak scalable untuk multi-user
- Data tidak dinamis

### Q: Kenapa tidak pakai database?
**A:** Untuk MVP (Minimum Viable Product) ini, hardcoded data sudah cukup karena:
- Hanya untuk 1 user (saya sendiri)
- Data CV jarang berubah
- Fokus pada pembelajaran UI/UX Flutter

Jika dikembangkan lebih lanjut, akan pakai:
- **Local**: SQLite, Hive, SharedPreferences
- **Remote**: Firebase Firestore, REST API + MySQL/PostgreSQL

### Q: Apakah ada autentikasi real di aplikasi ini?
**A:** **TIDAK**, saat ini autentikasi hanya dummy/simulasi.

Di login_screen.dart line 19-31, form hanya validasi apakah field kosong, tapi tidak cek kredensial ke database. Siapapun bisa login asal isi form.

**Untuk production**, perlu implementasi:
- Backend authentication (Firebase Auth, JWT, OAuth)
- Password hashing (bcrypt, SHA-256)
- Session management
- Secure storage untuk token

### Q: Bagaimana mencegah user akses HomeScreen tanpa login?
**A:** Saat ini **BELUM ADA proteksi**. User bisa langsung navigate ke HomeScreen jika tahu caranya.

**Solusi yang seharusnya:**
1. Implement authentication state management
2. Gunakan middleware/guard untuk protect route
3. Check authentication state di main.dart:
   ```dart
   home: isLoggedIn ? HomeScreen() : LoginScreen()
   ```
4. Save login state di SharedPreferences/Secure Storage

---

## 6. Pertanyaan Package & Library

### Q: Package apa saja yang digunakan?
**A:** Dari pubspec.yaml:
1. **flutter**: SDK utama Flutter
2. **fluttertoast** (^8.2.8): Untuk menampilkan toast notification
3. **flutter_test**: Untuk testing
4. **flutter_lints** (^6.0.0): Untuk linting/code quality

### Q: Apa fungsi package fluttertoast?
**A:** `fluttertoast` digunakan untuk menampilkan notifikasi toast (pesan popup singkat) yang muncul sebentar lalu hilang.

Contoh penggunaan di login_screen.dart line 21-25:
```dart
Fluttertoast.showToast(
  msg: "Login berhasil! Selamat datang 👋",
  backgroundColor: const Color(0xFF2E7D32),
  textColor: Colors.white,
);
```

**Kelebihan:**
- User-friendly untuk feedback singkat
- Tidak blocking UI (beda dengan AlertDialog)
- Bisa customize warna, durasi, posisi

### Q: Apakah ada alternatif untuk toast notification?
**A:** Ya, ada beberapa alternatif:
1. **SnackBar**: Built-in Flutter, muncul dari bawah
2. **AlertDialog**: Untuk notifikasi yang perlu user action
3. **Package lain**: `get`, `awesome_snackbar_content`, `top_snackbar_flutter`

Saya pilih fluttertoast karena ringan dan simple.

---

## 7. Pertanyaan Platform & Deployment

### Q: Platform apa saja yang support?
**A:** Aplikasi ini support **6 platform**:
1. **Android** (folder android/)
2. **iOS** (folder ios/)
3. **Web** (folder web/)
4. **Windows** (folder windows/)
5. **Linux** (folder linux/)
6. **macOS** (folder macos/)

Semua dari **satu codebase** yang sama!

### Q: Apa perbedaan build untuk Android vs iOS?
**A:**
**Android:**
- Build jadi file APK/AAB
- Command: `flutter build apk` atau `flutter build appbundle`
- Tidak perlu macOS untuk development
- Konfigurasi di `android/app/build.gradle.kts`

**iOS:**
- Build jadi file IPA
- Command: `flutter build ios`
- **HARUS** pakai macOS dengan Xcode
- Perlu Apple Developer Account untuk deploy ke App Store
- Konfigurasi di `ios/Runner.xcodeproj`

### Q: Jelaskan file pubspec.yaml dan fungsinya
**A:** `pubspec.yaml` adalah file konfigurasi utama Flutter project yang berisi:

1. **Metadata project** (name, description, version)
2. **SDK constraints** (versi Dart/Flutter yang dibutuhkan)
3. **Dependencies**: Package yang digunakan
4. **Dev dependencies**: Package untuk development (testing, linting)
5. **Assets**: File gambar, font, dll yang perlu di-bundle
   ```yaml
   assets:
     - assets/della.jpg
   ```

### Q: Bagaimana cara menjalankan aplikasi?
**A:**
```bash
# Install dependencies
flutter pub get

# Run di mode debug
flutter run

# Build untuk production
flutter build apk           # Android
flutter build web           # Web
flutter build windows       # Windows
```

---

## 8. Pertanyaan Problem Solving

### Q: Kendala apa yang dihadapi saat development?
**A:** Beberapa kendala yang saya hadapi:

1. **Responsive UI**: Awalnya pakai fixed size, tapi ketika test di device lain, layout berantakan
   - **Solusi**: Ganti pakai MediaQuery dan relative sizing

2. **Form Validation**: Bingung cara validasi multiple field sekaligus
   - **Solusi**: Pelajari GlobalKey<FormState> dan TextFormField validator

3. **Memory Leak**: Lupa dispose TextEditingController
   - **Solusi**: Always dispose controller di dispose() method

4. **Navigation**: User bisa back ke login setelah berhasil login
   - **Solusi**: Ganti push jadi pushReplacement

### Q: Bagaimana cara debug error di Flutter?
**A:** Cara debug yang saya pakai:
1. **Hot Reload** (r): Untuk quick changes
2. **Hot Restart** (R): Untuk restart app
3. **Print statements**: `print()` atau `debugPrint()`
4. **Debug Console**: Lihat error stack trace
5. **Flutter DevTools**: Tools visual untuk inspect widget tree, performance, dll
6. **Breakpoints**: Di VS Code/Android Studio

### Q: Kenapa pakai TextEditingController dan bagaimana cara dispose-nya?
**A:**
**Kenapa pakai TextEditingController:**
- Untuk mengakses dan mengontrol text di TextField
- Bisa ambil value: `_emailController.text`
- Bisa set value: `_emailController.text = "..."`
- Bisa listen perubahan text
- Bisa clear text: `_emailController.clear()`

**Cara dispose** (login_screen.dart line 34-37):
```dart
@override
void dispose() {
  _emailController.dispose();
  _passwordController.dispose();
  super.dispose();
}
```
Ini **PENTING** untuk:
- Mencegah memory leak
- Free up resources
- Best practice Flutter

**HARUS** dispose di method `dispose()` sebelum widget dihapus.

---

## 9. Pertanyaan Pengembangan Lanjutan

### Q: Apa kekurangan aplikasi ini?
**A:**
1. Tidak ada autentikasi real (dummy login)
2. Data hardcoded, tidak dinamis
3. Tidak ada database
4. Tidak bisa edit CV dari aplikasi
5. Tidak ada dark mode
6. Tidak ada multi-language
7. Tidak ada animasi yang menarik
8. Tidak ada export CV ke PDF

### Q: Fitur apa yang akan ditambahkan kedepannya?
**A:** Fitur yang saya rencanakan:
1. **Backend Integration**: Firebase/REST API untuk data dinamis
2. **Real Authentication**: Login dengan email/password real, mungkin Google Sign-In
3. **Edit Profile**: Bisa update CV dari aplikasi
4. **Export to PDF**: Download CV dalam format PDF
5. **Dark Mode**: Toggle light/dark theme
6. **Animations**: Smooth transitions dan micro-interactions
7. **Multi-language**: Indonesia & English
8. **Share CV**: Share link CV ke orang lain

### Q: Bagaimana cara implementasi dark mode?
**A:** Cara implement dark mode:
1. Define dark theme di main.dart
   ```dart
   theme: ThemeData.light(),
   darkTheme: ThemeData.dark(),
   themeMode: ThemeMode.system, // atau .light / .dark
   ```
2. Buat state untuk toggle theme
3. Save preference di SharedPreferences
4. Update colors di semua screen sesuai theme

---

## 10. Tips Demo & Presentasi

### Checklist Sebelum Demo:
- [ ] Pastikan aplikasi bisa run tanpa error
- [ ] Test semua fitur (login, logout, scroll, dll)
- [ ] Prepare device/emulator yang sudah ready
- [ ] Screenshot untuk backup jika ada masalah
- [ ] Charge laptop/phone

### Flow Demo:
1. Buka aplikasi di emulator/device
2. Jelaskan splash screen / login screen
3. Demo login (coba error validation dulu, baru sukses)
4. Tunjukkan home screen dan scroll ke bawah
5. Demo logout dengan dialog konfirmasi
6. Tunjukkan register screen jika ada
7. (Optional) Tunjukkan code di IDE

### Hal Yang Perlu Disiapkan:
1. Penjelasan singkat project (elevator pitch 1 menit)
2. Diagram flow aplikasi
3. Pengetahuan tentang setiap file dan kegunaannya
4. Prepare jawaban untuk "kenapa pakai X?"
5. Jujur jika ada yang tidak tahu, jangan asal jawab

---

## Kesimpulan

Project ini adalah aplikasi mobile biodata/CV yang dibangun dengan Flutter, menampilkan informasi pribadi, pengalaman kerja, pendidikan, skills, dan sertifikat. Aplikasi ini menggunakan Material Design 3 dengan UI yang responsive dan modern.

**Key Features:**
- Login & Register (dummy authentication)
- Display CV dengan layout yang menarik
- Responsive design untuk berbagai ukuran layar
- Cross-platform (Android, iOS, Web, Desktop)
- Toast notification untuk user feedback

**Tech Stack:**
- Flutter SDK
- Dart Language
- Material Design 3
- Package: fluttertoast

**Good Luck! 🚀**
