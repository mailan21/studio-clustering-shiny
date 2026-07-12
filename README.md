# studio-clustering-shiny

Aplikasi berbasis web interaktif yang dibangun menggunakan **R Shiny** dan **Shinydashboard** untuk melakukan analisis pengelompokan (*clustering*) data secara dinamis menggunakan algoritma **K-Means**. 

Proyek ini dibuat untuk memenuhi tugas kelompok mata kuliah, dengan menerapkan alur kerja (*workflow*) berbasis Git/GitHub menggunakan strategi *branching* per anggota.

## Tentang Proyek
Proyek ini menyediakan sebuah studio analisis data di mana pengguna dapat mengunggah berkas dataset (Excel/CSV) apa saja secara dinamis, menentukan jumlah kluster ($k$) secara optimal, hingga mengunduh hasil pelabelan data. Repositori ini dirancang transparan dengan melampirkan riwayat kontribusi setiap anggota tim di *branch* masing-masing sebelum digabungkan ke `main`.

## Fitur Utama
### 1. Dashboard & Ringkasan Data
* Menyediakan statistik deskriptif otomatis (Mean, Median, Min, Max) dari berkas yang diunggah.
* Menampilkan informasi dimensi matrix dan gambaran umum dataset.
### 2. Eksplorasi Data Mentah
* Fitur *data viewer* dalam bentuk tabel interaktif yang mendukung pencarian (*searching*), pengurutan (*sorting*), dan filtrasi data sebelum diproses.
### 3. Optimasi Kluster (Elbow Method)
* Grafik evaluasi *Within-Cluster Sum of Squares* (WSS) untuk membantu pengguna menentukan jumlah kluster ($k$) terbaik secara visual berdasarkan patahan grafik (siku).
### 4. Studio Analisis K-Means
* Mesin komputasi algoritma K-Means dengan penanganan otomatis untuk data non-numerik.
* Visualisasi grafik hasil pengelompokan menggunakan metode reduksi dimensi *Principal Component Analysis* (PCA).
### 5. Unduh Hasil Akhir
* Fitur ekspor berkas di mana hasil pelabelan nomor kluster otomatis digabungkan ke data asli dan dapat diunduh kembali menjadi file baru.


## Struktur Repository
```text
studio-clustering-shiny/
├── app.R          # Kode utama aplikasi Shiny (UI + Server)
└── README.md      # Dokumentasi proyek
````

## Software yang Dipakai
Proyek dibangun di R dengan packages yang dipakai sebagai berikut:

| Packages | Keterangan |  
|---|---|
| shiny | kerangka kerja aplikasi web interaktif |
| shinydashboard | UI bertema dashboard untuk Shiny |
| tidyverse | manipulasi data dan visualisasi grafis (ggplot2, dplyr, readr) |
| readxl | membaca berkas dataset Excel |
| cluster | komputasi algoritma K-Means |
| factoextra | visualisasi grafis kluster dan elbow plot profesional |

## Cara Penggunaan
1. Instalasi packages
   ```R
   install.packages(c(
     "shiny", "shinydashboard", "tidyverse", 
     "readxl", "cluster", "factoextra"
   ))
2. Clone Repository di RStudio
   git clone [https://github.com/mailan21/studio-clustering-shiny.git](https://github.com/mailan21/studio-clustering-shiny.git)
   cd studio-clustering-shiny
3. Buka app.R di RStudio.
4. Jalankan aplikasi dengan menekan tombol Run App (atau gunakan pintasan Ctrl + Shift + Enter).

## Kontributor
Kelompok 5 Komputasi Statistika - Statistika B - Universitas Negeri | Nama | NIM | Branch | Github  
|---|---|---|---|
| Rafif Aryaputra Martino | 1314624041 | `branch-dd` | `@rafifaryaputramartino-spec`|
| Ailsa Larasati | 1314624042 | `branch-ail5a` | `@ail5a` |
| Tara Naira Ramadhani | 1314624050 | `branch-taranairaa` | `@taranairaa` |
| Mailan Tiorent Simbolon | 1314624054 | `branch-mailan` | `@mailan21` |
| Muhammad Rafi Ramadhan | 1314624072 | `branch-Rafi` | `@jordanrafi62-del` |
|Muhammad Irsyad Idzharulhaq | 1314624075 | `branch-irsyad` | `@Irsyad-9` |
