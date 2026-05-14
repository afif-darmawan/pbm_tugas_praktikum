# pbm_tugas_praktikum

# Tugas Praktikum PBM

Aplikasi manajemen katalog produk dengan fitur manajemen draf, autentikasi, dan pengumpulan tugas yang terintegrasi.

## 📸 Screenshot Aplikasi

Berikut adalah dokumentasi antarmuka (UI) dari aplikasi Saya:

### 1. Autentikasi & Beranda
| Login Screen | Home Screen |
| :---: | :---: |
| <img src="Login_Screen.png" width="250"> | <img src="Home_Screen.png" width="250"> |

### 2. Manajemen Produk
| Daftar Produk | Tambah Produk | Hapus Produk |
| :---: | :---: | :---: |
| <img src="Product_Screen.png" width="250"> | <img src="Tambah_Product_Screen.png" width="250"> | <img src="Hapus_Product_Screen.png" width="250"> |

### 3. Notifikasi & Sesi
| Produk Disimpan | Logout | Tugas Screen | Berhasil Kirim |
| :---: | :---: | :---: | :---: |
| <img src="PopUp_Product_Disimpan.png" width="250"> | <img src="Logout_Screen.png" width="250"> | <img src="Tugas_Screen.png" width="250"> | <img src="Berhasil_Kirim_Tugas.png" width="250"> |

---

## 📁 Struktur Folder Project

Berikut adalah struktur direktori utama pada folder `lib` dalam proyek ini:

```text
lib/
├── models/          # Berisi blueprint data (Product & User model)
├── screens/         # Berisi file UI/Tampilan utama aplikasi
├── services/        # Menangani komunikasi data (API Service)
├── utils/           # Konfigurasi tema, konstanta, dan helper
└── main.dart        # Entry point utama aplikasi Flutter

## Fitur Utama
* **Autentikasi User:** Pengamanan akses masuk ke dalam aplikasi.
* **Katalog Produk:** Menampilkan daftar produk yang tersedia.
* **Manajemen Draft:** Fitur untuk menambah dan menghapus data produk.
* **Pop-up Feedback:** Memberikan notifikasi visual saat aksi berhasil dilakukan.
