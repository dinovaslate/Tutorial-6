# Tugas 7 - Aplikasi Flutter E-Commerce

Aplikasi Flutter sederhana bertema dashboard e-commerce dengan tiga aksi utama: melihat daftar produk, menambah produk, dan keluar dari aplikasi.

## Jawaban Pertanyaan

1. **Stateless widget vs stateful widget**  
   Stateless widget adalah widget yang tidak menyimpan perubahan data internal; tampilannya hanya bergantung pada parameter yang diterima saat dibuat dan tidak akan berubah setelah di-render. Stateful widget memiliki objek `State` yang dapat menyimpan data atau kondisi dan bisa diperbarui melalui `setState()`, sehingga tampilan dapat berubah selama siklus hidupnya. Perbedaan utama keduanya terletak pada kemampuan stateful widget untuk merender ulang dirinya ketika terjadi perubahan state internal.

2. **Widget yang digunakan dan fungsinya**  
   - `MaterialApp`: Menjadi root aplikasi serta menyediakan konfigurasi tema dan navigasi.  
   - `Scaffold`: Menyediakan struktur dasar layar, termasuk `AppBar` dan area konten.  
   - `AppBar`: Menampilkan judul dashboard e-commerce.  
   - `Container` dengan `BoxDecoration`: Membuat latar belakang gradien agar tampilan terasa modern.  
   - `Column`, `SizedBox`, `Padding`, dan `Center`: Mengatur tata letak konten agar tersusun rapi.  
   - `Icon` dan `Text`: Menampilkan ikon toko dan berbagai teks penjelas.  
   - `ElevatedButton.icon`: Menyediakan tiga tombol aksi dengan ikon dan label.  
   - `SnackBar` & `ScaffoldMessenger`: Menampilkan pesan umpan balik ketika tombol ditekan.

3. **Fungsi `setState()` dan variabel yang terdampak**  
   `setState()` memberi tahu Flutter bahwa terjadi perubahan pada state sehingga widget perlu dibangun ulang dengan data terbaru. Semua variabel yang dideklarasikan di dalam objek `State` dan dibaca di metode `build()` atau metode lain yang mempengaruhi tampilan akan terdampak oleh pemanggilan `setState()`. (Pada implementasi ini, tidak ada state yang berubah karena seluruh UI bersifat stateless.)

4. **Perbedaan `const` dan `final`**  
   `const` menandakan nilai konstan yang sudah pasti diketahui saat kompilasi (compile-time constant) dan akan diperlakukan sebagai objek yang tidak berubah sama sekali. `final` menandakan variabel hanya dapat diinisialisasi sekali, tetapi nilainya dapat ditentukan saat runtime. Semua `const` juga secara implisit `final`, namun tidak semua `final` adalah `const`.

5. **Implementasi checklist**  
   - Membuat tema e-commerce dengan skema warna hijau toska, latar gradien, dan ikon toko di beranda.  
   - Menambahkan tiga `ElevatedButton.icon` untuk aksi melihat daftar produk, menambah produk, dan logout dengan warna tombol yang berbeda.  
   - Menggunakan `ScaffoldMessenger` untuk menampilkan `SnackBar` dengan pesan sesuai tombol yang ditekan.  
   - Mengisi README ini dengan jawaban konsep Flutter sesuai permintaan tugas.

## Menjalankan Aplikasi

Pastikan Flutter SDK pada folder `/flutter` sudah diinisialisasi. Dari direktori proyek, jalankan perintah berikut:

```bash
flutter run
```
