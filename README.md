[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/d67U5xdR)
# Sociolla Web Scraping & ETL Pipeline: COSRX Products
> **Data Extraction & Transformation for E-Commerce Market Research**

## Project Overview
Proyek ini mendemonstrasikan proses **End-to-End ETL (Extract, Transform, Load)** dengan mengambil data produk kecantikan merk 'COSRX' dari e-commerce **Sociolla**. 

Tujuan utama dari proyek ini adalah untuk membangun pipeline yang mampu mengumpulkan informasi harga, rating, dan volume penjualan guna keperluan analisis kompetitor atau monitoring harga pasar secara *real-time*.

---

## ETL Architecture

### 1. Extract (Web Scraping)
Menggunakan **Selenium WebDriver** dikombinasikan dengan **BeautifulSoup** untuk menangani tantangan pada website modern:
* **Dynamic Content:** Menangani rendering JavaScript agar data produk muncul sepenuhnya sebelum diambil.
* **Automation:** Menjelajahi halaman produk secara otomatis untuk mengumpulkan atribut:
    * `nama_produk`
    * `harga_produk`
    * `rating`
    * `jumlah_produk_terjual`

### 2. Transform (Data Cleaning)
Pemrosesan data mentah dilakukan menggunakan **Pandas** untuk memastikan integritas data sebelum masuk ke database:
* **Type Casting:** Mengonversi harga dan jumlah terjual dari string menjadi format numerik (`int64`/`float64`).
* **Data Validation:** Memastikan tidak ada data duplikat dan menangani nilai yang hilang (*missing values*).
* **Feature Cleaning:** Membersihkan karakter khusus (seperti simbol mata uang) dari kolom harga.

### 3. Load (Database Storage)
Data yang telah bersih disimpan ke dalam dua format untuk kebutuhan berbeda:
* **Flat File:** Disimpan sebagai `.csv` untuk analisis cepat.
* **Relational Database:** Dimuat ke dalam **PostgreSQL** menggunakan perintah DDL dan DML untuk penyimpanan jangka panjang yang terstruktur.

---

## Tech Stack & Libraries
* **Language:** Python
* **Extraction:** Selenium, BeautifulSoup4
* **Processing:** Pandas
* **Database:** PostgreSQL (pgAdmin 4)
