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



# 💻 Cara Install Docker
   Untuk Windows & macOS:
   - Kunjungi situs resmi: https://www.docker.com/products/docker-desktop
   - Unduh dan install Docker Desktop.
   - Setelah instalasi, jalankan Docker Desktop. Pastikan statusnya running. 
     
## 1. Clone Repository
  Clone repository backend dan frontend ke dalam direkori lokal
   - Backend :  
     ```(git clone https://github.com/ghinasafina/PBF-Backend.git)```
   - Frontend :  
     ```(git clone https://github.com/ghinasafina/PBF-Frontend.git)```

Tunggu hingga semua container (frontend, backend, nginx) aktif.  
## 2. Dockkerfile Backend (CI4)
untuk menulis urutan command yang akan dijalankan saat build container. Command yg ada di docker file berpengaruh terhadap setting dan konfigurasi proyek baik be maupun fe.
Buat file: ```backend/Dockerfile```

```FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies + PHP extensions
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring gd intl

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy project files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --prefer-dist

# Set permissions for writable folder
RUN chown -R www-data:www-data /var/www/writable

# Expose port and run php-fpm
EXPOSE 9001
CMD ["php-fpm"]
```
## 3. Dockerfile Frontend (Laravel)
untuk menulis urutan komen yang akan dijalankan saat build container. Command yg ada di docker file berpengaruh terhadap setting dan konfigurasi proyek baik be maupun fe.
Buat file: ```frontend/Dockerfile```

```# Base PHP image
FROM php:8.2-fpm

# Install PHP dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
```
## 4. env
Fungsi pokok dari file `.env` di Laravel adalah **menyimpan pengaturan lingkungan (environment)** secara terpisah dari kode sumber. File ini memiliki peran penting karena memungkinkan aplikasi Laravel untuk lebih fleksibel dan mudah disesuaikan dengan lingkungan tempat aplikasi dijalankan, seperti local, staging, maupun production.  

## 5. File docker-compose.yml
merupakan file yang akan dituju ketika kita akan membuild container. Docker compose berisi tentang informasi dan konfigurasi mengenai inti dari hasil dari proyek yg nanti dibuild, misal port utk fe adalah 80:80.
Buat di root folder (my-project/docker-compose.yml):
```
version: "3.8"

services:
  # === MySQL Database ===
  mysql:
    image: mysql:8
    ports:
      - "3307:3306" # hostPort:containerPort
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: app
      MYSQL_USER: user
      MYSQL_PASSWORD: secret
    volumes:
      - mysql-data:/var/lib/mysql

  # === Laravel Frontend ===
  frontend:
    build:
      context: ./frontend
    volumes:
      - ./frontend:/var/www
    depends_on:
      - mysql
    networks:
      - appnet

  # === CI4 Backend ===
  backend:
    build:
      context: ./backend
    volumes:
      - ./backend:/var/www
    depends_on:
      - mysql
    networks:
      - appnet

  # === NGINX Reverse Proxy ===
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - frontend
      - backend
    networks:
      - appnet

volumes:
  mysql-data:

networks:
  appnet:
    driver: bridge
```

## 6. Nginx.conf
merupakan file yang berisi konfigurasi server untuk nanti berjalannya proyek.
```worker_processes 1;

events {
    worker_connections 1024;
}

http {
    include mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;

    server {
        listen 80;
        index index.php index.html;
        server_name localhost;

        root /var/www/public;

        location / {
            try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
            include fastcgi_params;
            fastcgi_pass frontend:9000;
            fastcgi_index index.php;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param DOCUMENT_ROOT $document_root;
        }

        location ~ /\.ht {
            deny all;
        }
    }
}
```

## 7. Build Container
untuk membangun satu kontainer utuh dan menyatukan semua bagiain proyek (BE, FE, Server, dan database) yang berjalan dalam satu lingkungan.

```docker-compose up --build```






