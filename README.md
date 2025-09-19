# DOKUMENTASI PENGGUNA
## Mail Archive Surat Resmi Desa Karangduren

**Versi**: 1.0  
**Platform**: Flutter Web Application  
**Lokasi**: Desa Karangduren, Kecamatan Pakisaji  
**Tujuan**: Sertikom Web - Digitalisasi Arsip
**Dokumentasi**: Dokumentasi tertulis dan bergambar pada file Dokumentasi Pengguna Mail Archive.pdf

---

## DAFTAR ISI

1. [Pendahuluan](#pendahuluan)
2. [Panduan Penggunaan](#panduan-penggunaan)
3. [Fitur dan Fungsi](#fitur-dan-fungsi)
4. [Spesifikasi Teknis](#spesifikasi-teknis)
5. [Troubleshooting](#troubleshooting)
6. [Informasi Support](#informasi-support)

---

## PENDAHULUAN

### Tentang Aplikasi
Mail Archive Surat Resmi adalah aplikasi web berbasis Flutter yang dirancang khusus untuk mengelola arsip surat resmi di Desa Karangduren. Aplikasi ini menyediakan solusi digital modern untuk administrasi dokumen dengan interface yang user-friendly dan fitur pencarian real-time.

### Tujuan Aplikasi
- Digitalisasi arsip surat resmi desa
- Meningkatkan efisiensi pengelolaan dokumen
- Menyediakan sistem pencarian yang cepat dan akurat  
- Mendukung program Sertikom Web untuk inovasi teknologi desa

### Keunggulan
✅ **Interface Modern** - Design gradient turquoise-purple yang menarik  
✅ **Real-time Search** - Pencarian langsung tanpa reload halaman  
✅ **PDF Integration** - Upload dan preview dokumen PDF  
✅ **Responsive Design** - Dapat diakses dari desktop dan mobile  
✅ **Easy Navigation** - Navbar yang intuitif dan konsisten

---

## PANDUAN PENGGUNAAN

### Akses Aplikasi
1. Buka browser web (Chrome, Firefox, Safari, atau Edge)
2. Masukkan URL aplikasi Mail Archive Desa Karangduren
3. Aplikasi siap digunakan tanpa proses login

### Navigasi Utama

#### **Navbar Components**
- **🏠 Karangduren Official** (Logo) → Kembali ke halaman Home
- **📁 Kategori** → Halaman manajemen kategori surat
- **ℹ️ About** → Informasi developer aplikasi

---

## FITUR DAN FUNGSI

### 1. HALAMAN HOME

**Tampilan**: Landing page dengan card informasi desa
**Fungsi**: 
- Menampilkan identitas "Desa Karangduren di kecamatan Pakisaji"
- Tombol outline "Archive Surat Resmi" untuk akses ke fitur utama

**Cara Penggunaan**:
1. Halaman ini adalah pintu masuk aplikasi
2. Klik tombol "Archive Surat Resmi" untuk mulai mengelola dokumen
3. Gunakan navbar untuk navigasi ke halaman lain

---

### 2. HALAMAN KATEGORI

**Tampilan**: Form input dan tabel manajemen kategori
**Fungsi**: CRUD (Create, Read, Update, Delete) kategori surat

#### **A. Tambah Kategori**
**Langkah-langkah**:
1. Ketik nama kategori pada input field
2. Klik tombol **"Tambah"** (warna #A503FC)
3. Kategori baru akan muncul di tabel dengan ID otomatis

#### **B. Lihat Kategori**
**Informasi Tabel**:
- **ID**: Nomor urut otomatis
- **Kategori**: Nama kategori (contoh: Undangan, Nota Dinas, Pengumuman)
- **Action**: Tombol Edit dan Hapus

#### **C. Edit Kategori**
**Langkah-langkah**:
1. Klik tombol **"Edit"** (warna #7FDCB7) pada kategori yang ingin diubah
2. Pop-up **"Edit Kategori"** muncul dengan data lama
3. Ubah nama kategori sesuai kebutuhan
4. Klik **"Simpan"** untuk menyimpan atau **"Kembali"** untuk batal

#### **D. Hapus Kategori**
**Langkah-langkah**:
1. Klik tombol **"Hapus"** (warna #7FDCB7) pada kategori
2. Pop-up konfirmasi muncul: *"Anda yakin akan menghapus kategori ini?"*
3. Klik **"Ya"** untuk hapus atau **"Batal"** untuk membatalkan

---

### 3. HALAMAN ARCHIVE SURAT RESMI

**Tampilan**: Search bar, tombol tambah, dan tabel surat
**Fungsi**: Manajemen lengkap arsip surat resmi

#### **A. Pencarian Real-time**
**Fitur**: Pencarian langsung tanpa reload
**Cara Penggunaan**:
1. Gunakan search bar di bagian atas
2. Ketik judul atau nomor surat
3. Hasil akan muncul otomatis di tabel
4. Tabel menampilkan: No, Judul, Kategori, Action

#### **B. Tambah Surat Baru**
**Langkah-langkah**:
1. Klik tombol **"Tambah"** di kanan atas
2. Pop-up **"Upload Surat Resmi"** muncul
3. Isi form dengan data:
   - **No**: Nomor surat resmi
   - **Judul**: Nama/judul surat  
   - **Kategori**: Pilih dari dropdown (data dari halaman Kategori)
   - **Upload File**: Pilih file PDF (hanya PDF diterima)
4. Klik **"Simpan"** atau **"Kembali"** untuk batal

#### **C. Edit Surat**
**Langkah-langkah**:
1. Klik tombol **"Edit"** pada baris surat
2. Pop-up dengan data lama akan muncul
3. Ubah informasi yang diperlukan
4. Ganti file PDF jika perlu
5. Simpan perubahan

#### **D. Hapus Surat**
**Langkah-langkah**:
1. Klik tombol **"Hapus"** pada baris surat
2. Konfirmasi: *"Anda yakin akan menghapus surat ini?"*
3. Pilih **"Ya"** atau **"Batal"**
4. Data dan file akan dihapus permanen

#### **E. Lihat File PDF**
**Langkah-langkah**:
1. Klik tombol **"Lihat"** pada baris surat
2. Halaman View akan terbuka
3. File PDF ditampilkan dalam viewer
4. Gunakan kontrol untuk navigasi dokumen

---

### 4. HALAMAN ABOUT

**Tampilan**: Halaman informasi developer
**Fungsi**: Menampilkan profil dan data diri pengembang aplikasi
**Akses**: Klik menu "About" di navbar

---

## SPESIFIKASI TEKNIS

### Platform dan Framework
- **Frontend**: Flutter Web
- **Design**: Responsive (Desktop & Mobile)
- **Color Scheme**: Gradient Turquoise (#7FDCB7) to Purple (#A503FC)
- **UI Pattern**: Modern Material Design

### Format File dan Validasi
- **File Surat**: Khusus PDF (.pdf)
- **Upload Validation**: Real-time file type checking
- **Size Limit**: Disesuaikan dengan konfigurasi server
- **Preview**: Built-in PDF viewer

### Fitur Teknis
- **Real-time Search**: Instant filtering tanpa page reload
- **Modal System**: Pop-up untuk form dan konfirmasi
- **Dynamic Dropdown**: Kategori terupdate otomatis
- **Responsive Table**: Adaptif untuk berbagai ukuran layar

### Browser Support
- Google Chrome (Recommended)
- Mozilla Firefox
- Safari
- Microsoft Edge

---

## TROUBLESHOOTING

### Masalah Umum dan Solusi

#### **File Tidak Terupload**
**Penyebab**: Format file salah atau ukuran terlalu besar
**Solusi**: 
- Pastikan file berformat PDF
- Kompres file PDF jika ukuran terlalu besar
- Coba upload file PDF lain untuk testing

#### **Pencarian Tidak Menampilkan Hasil**
**Penyebab**: Loading data atau koneksi lambat
**Solusi**:
- Tunggu beberapa detik untuk loading
- Refresh halaman jika diperlukan
- Periksa ejaan kata kunci pencarian

#### **Pop-up Tidak Muncul**
**Penyebab**: Browser memblokir pop-up
**Solusi**:
- Izinkan pop-up di browser settings
- Disable ad-blocker sementara
- Gunakan browser yang kompatibel

#### **Kategori Tidak Muncul di Dropdown**
**Penyebab**: Belum ada kategori yang dibuat
**Solusi**:
- Buat kategori terlebih dahulu di halaman Kategori
- Refresh halaman Archive setelah menambah kategori

#### **Interface Tidak Responsive**
**Penyebab**: Browser tidak mendukung atau cache lama
**Solusi**:
- Clear browser cache dan cookies
- Update browser ke versi terbaru
- Gunakan browser yang mendukung Flutter Web

---

## BEST PRACTICES

### Penggunaan Optimal
1. **Setup Awal**: Buat kategori terlebih dahulu sebelum upload surat
2. **Penamaan File**: Gunakan nama file PDF yang deskriptif dan jelas
3. **Organisasi**: Pilih kategori yang tepat untuk setiap surat
4. **Backup**: Simpan file PDF asli sebagai backup lokal
5. **Pencarian**: Gunakan kata kunci spesifik untuk hasil yang akurat

### Workflow Recommended
1. **Persiapan** → Setup kategori di halaman Kategori
2. **Input Data** → Upload surat-surat di halaman Archive  
3. **Organisasi** → Pastikan setiap surat memiliki kategori yang tepat
4. **Maintenance** → Gunakan fitur edit untuk update data berkala
5. **Pencarian** → Manfaatkan search real-time untuk akses cepat

---

## INFORMASI SUPPORT

### Developer Information
**Pengembang**: [Lihat halaman About untuk detail lengkap]
**Platform**: Flutter Web Application
**Tujuan**: Sertikom Web - Digitalisasi Arsip Desa
**Status**: Active Development

### Kontak dan Bantuan
**Lokasi**: Desa Karangduren, Kecamatan Pakisaji
**Support**: Hubungi developer melalui informasi di halaman About
**Update**: Aplikasi akan diperbarui sesuai kebutuhan dan feedback pengguna

### Feedback dan Saran
Untuk memberikan feedback atau saran pengembangan aplikasi, silakan hubungi developer melalui kontak yang tersedia di halaman About.

---

## PENUTUP

Dokumentasi ini dibuat untuk membantu pengguna memahami dan mengoptimalkan penggunaan aplikasi Mail Archive Surat Resmi Desa Karangduren. Aplikasi ini merupakan bagian dari upaya digitalisasi administrasi desa dan mendukung program Sertikom Web.

Dengan mengikuti panduan ini, diharapkan pengguna dapat memanfaatkan semua fitur aplikasi secara maksimal untuk meningkatkan efisiensi pengelolaan arsip surat resmi di lingkungan Desa Karangduren.

---

**© 2024 Mail Archive Surat Resmi - Desa Karangduren**  
*Dikembangkan untuk Sertikom Web*

---

*Catatan: Dokumentasi ini akan diperbarui seiring dengan pengembangan dan penambahan fitur aplikasi*