# DevOps
Cara kerja yang menyatukan tim pembuat aplikasi dan tim pengelola sistem agar bisa bekerja sama lebih baik.
# 🐳 Apa itu Docker?
Docker adalah sebuah platform open-source yang digunakan untuk mengembangkan, mengirim, dan menjalankan aplikasi di dalam container. Dengan Docker, kalian tidak perlu menginstal semua komponen satu per satu di komputer — cukup jalankan container, dan aplikasinya langsung bisa digunakan. Ini membuat pengembangan dan pengujian aplikasi jadi lebih mudah, cepat, dan konsisten, karena lingkungan kerja di setiap komputer akan selalu sama berkat penggunaan container tersebut.

## Struktur directory
.  
├── backend/             # Folder untuk source code backend (misal: CodeIgniter 4)  
│   ├── Dockerfile       # File untuk membangun image backend  
│   └── .env             # File konfigurasi environment backend  
│  
├── frontend/            # Folder untuk source code frontend (misal: Laravel)  
│   ├── Dockerfile       # File untuk membangun image frontend  
│   └── .env             # File konfigurasi environment frontend  
│  
├── mysql-init/          # Inisialisasi awal database MySQL  
│   └── db_pengelolaan_nilai.sql  # File SQL untuk membuat database & tabel awal  
│  
├── nginx/               # Konfigurasi NGINX  
│   └── nginx.conf     # (misalnya) konfigurasi reverse proxy  
│  
├── docker-compose.yml   # File utama untuk menjalankan semua container  
└── README.md            # Dokumentasi proyek  

## 🧰 Kebutuhan Awal
Sebelum mulai, pastikan software berikut sudah terinstal:

- **Docker Desktop** [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
- **Git** [https://git-scm.com](https://git-scm.com)

## 📥 Langkah Instalasi
## 1. Clone Repository
  Clone repository backend dan frontend ke dalam direkori lokal
   - Backend :  
     ```(git clone https://github.com/ghinasafina/PBF-Backend.git)```
   - Frontend :  
     ```(git clone https://github.com/ghinasafina/PBF-Frontend.git)```

## 2. Buat File Environment
Salin file environment dari contoh:
```
cp frontend/.env.example frontend/.env
cp backend/.env.example backend/.env
```
Untuk menjalankan proyek secara lokal, rename file .env.example menjadi .env

⚙️ Menjalankan Aplikasi
Untuk membangun dan menjalankan semua service secara otomatis:
```
docker compose up --build
```
Docker akan:
    - Membuat container untuk Laravel, CodeIgniter, MySQL, dan NGINX
    - Mengatur koneksi antar layanan
    - Menjalankan semua aplikasi di dalam container terisolasi

🌐 Akses Layanan
- Frontend Laravel:
  ```http://localhost:8000```
- Backend CodeIgniter:
  ```http://localhost:8080```

🛠️ Konfigurasi Database
Pastikan konfigurasi koneksi database sesuai di file .env.docker, contoh:
```
DB_HOST=db
DB_PORT=3306
DB_DATABASE=app_db
DB_USERNAME=root
DB_PASSWORD=root
```
🔄 Perubahan & Rebuild
Jika kamu mengubah kode atau konfigurasi, rebuild dengan:
```
docker compose down
docker compose up --build
```

🛑 Menghentikan Layanan
Untuk menghentikan semua container:
```
docker compose down
```




