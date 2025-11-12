# Football News Mobile

Aplikasi Flutter yang menyajikan beragam menu terkait berita sepak bola. Halaman beranda menampilkan kartu profil singkat, tiga menu utama (lihat berita, tambah berita, logout), serta snackbar kontekstual untuk setiap interaksi. Drawer di sisi kiri memudahkan navigasi antar halaman, sementara halaman formulir memungkinkan pengguna memasukkan berita baru dengan validasi yang jelas.

## Jawaban Pertanyaan Tugas 7

1. **Widget tree dan hubungan parent-child**  
   Widget tree adalah struktur hierarki yang merepresentasikan seluruh widget yang menyusun antarmuka Flutter. Setiap widget bisa memiliki satu atau lebih child yang berada di bawahnya. Parent mengontrol tata letak dan perilaku child (misalnya `Row` mengatur posisi anak secara horizontal), sedangkan child mewarisi konteks dan constraint dari parent. Perubahan pada tree akan memicu Flutter untuk merender ulang bagian yang terdampak.

2. **Widget yang digunakan dan fungsinya**  
   - `MaterialApp`: membungkus seluruh aplikasi dengan material design dan menyediakan routing, tema, serta konfigurasi dasar.  
   - `Scaffold`: kerangka halaman material yang menyediakan slot standar seperti `AppBar`, `body`, `Drawer`, dan `SnackBar`.  
   - `AppBar`: menampilkan judul aplikasi dan aksi global dengan gaya konsisten di setiap halaman.  
   - `Drawer`, `DrawerHeader`, `ListView`, `ListTile`: membangun navigasi samping dan menampung rute-rute penting (Home & Add News).  
   - `SingleChildScrollView`, `LayoutBuilder`, `Column`, `Row`: menyusun konten responsif yang tetap nyaman di layar sempit maupun lebar.  
   - `Card`: menyajikan informasi profil secara ringkas dengan gaya material.  
   - `NewsCard` (custom widget berbasis `Material` + `InkWell`): menampilkan menu utama dengan ikon, warna, dan aksi berbeda.  
   - `Form`, `TextFormField`, `DropdownButtonFormField`, `SwitchListTile`: mengumpulkan input berita baru sekaligus menjalankan validasi.  
   - `ElevatedButton`: memicu penyimpanan berita setelah validasi.  
   - `SnackBar` dan `AlertDialog`: memberikan umpan balik langsung ketika pengguna menekan tombol atau mengirimkan form.

3. **Fungsi `MaterialApp`**  
   `MaterialApp` menyediakan konfigurasi tingkat atas seperti tema, lokal, navigasi, serta integrasi dengan material design. Widget ini sering dijadikan root karena menyiapkan `Navigator`, `Theme`, dan elemen material penting lain yang kemudian dapat diakses oleh semua widget turunan melalui `BuildContext`.

4. **Perbedaan `StatelessWidget` dan `StatefulWidget`**  
   `StatelessWidget` tidak menyimpan state yang bisa berubah; seluruh UI ditentukan oleh properti yang diberikan. `StatefulWidget` memiliki objek `State` terpisah yang dapat menyimpan data dan memicu rebuild saat berubah. Gunakan `StatelessWidget` untuk UI statis atau yang hanya bergantung pada input eksternal, sedangkan `StatefulWidget` dipilih ketika kita perlu mengelola state internal yang dinamis (misalnya input formulir atau animasi).

5. **Peran `BuildContext`**  
   `BuildContext` merepresentasikan posisi sebuah widget di dalam widget tree. Konteks ini penting untuk mengakses data turun-temurun seperti tema (`Theme.of(context)`), navigator (`Navigator.of(context)`), maupun ukuran tampilan. Pada metode `build`, konteks digunakan agar widget dapat mengambil dependensi dan berinteraksi dengan parent secara tepat.

6. **Konsep hot reload vs hot restart**  
   Hot reload menyuntikkan perubahan kode ke VM dan mencoba mempertahankan state aplikasi yang sedang berjalan; cocok untuk iterasi UI yang cepat. Hot restart memulai ulang aplikasi sepenuhnya, sehingga state kembali ke kondisi awal. Gunakan hot reload ketika ingin melihat perubahan visual tanpa kehilangan data sementara, sedangkan hot restart diperlukan apabila perubahan menyentuh inisialisasi global atau terjadi inkonsistensi state.

## Checklist Tutorial 8

- **Model & provider siap pakai** — `lib/models/news_entry.dart` mendeskripsikan struktur respons dari endpoint JSON Django, sedangkan `lib/main.dart` membungkus aplikasi dengan `Provider<CookieRequest>` agar semua halaman dapat berbagi sesi autentikasi.
- **Autentikasi penuh Django** — `lib/screens/login_page.dart` dan `lib/screens/register_page.dart` memanggil endpoint `/auth/login/` dan `/auth/register/` Django menggunakan `pbp_django_auth`, dilengkapi validasi input, indikator pemrosesan, serta snackbar hasil operasi. Logout tersedia di `lib/screens/menu.dart` serta `lib/widgets/left_drawer.dart` melalui endpoint `/auth/logout/`.
- **Pengambilan dan penampilan data** — `lib/screens/news_entry_list.dart` menggunakan `FutureBuilder` untuk mengambil data dari `$baseUrl/json/`, menampilkan daftar kartu berita interaktif (`lib/widgets/news_entry_card.dart`), serta menangani kasus gagal koneksi dengan tombol retry.
- **Halaman detail berita** — `lib/screens/news_detail.dart` menampilkan informasi lengkap (kategori, tanggal, jumlah views, thumbnail yang diproksi melalui Django) sesuai struktur model pada backend.
- **Form input terintegrasi** — `lib/screens/news_form_page.dart` mengirim news baru ke endpoint Django `/create-news-flutter/` dalam format JSON. Form memuat validasi, dropdown kategori, switch featured, serta indikator loading agar pengguna tahu ketika data sedang dikirim.

## Menjalankan Proyek

```bash
flutter run
```
