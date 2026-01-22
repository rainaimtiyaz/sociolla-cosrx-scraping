/*
=================================================
Milestone 1

Nama  : Raina Imtiyaz
Batch : CODA-RMT-012

Program ini dibuat untuk mengimpor data produk COSRX
dari file CSV hasil web scraping situs Sociolla yang
telah melalui proses pembersihan data dengan nama
file 'clean_sociolla_cosrx_products.csv' ke dalam
database, serta memeriksa apakah data tersebut
memerlukan proses normalisasi.
=================================================
*/

-- Di query tools postgres
CREATE DATABASE milestone1;

-- Di query tools milestone1
-- Membuat table cosrx_products untuk menampung data csv
CREATE TABLE cosrx_products (
    id SERIAL PRIMARY KEY,
    nama_produk VARCHAR(255) NOT NULL,
    harga_produk INTEGER NOT NULL,
    rating FLOAT,
    jumlah_produk_terjual INTEGER
);

-- Menambahkan data dari clean_sociolla_cosrx_products.csv ke dalam table cosrx_products
COPY cosrx_products(nama_produk, harga_produk, rating, jumlah_produk_terjual)
FROM 'C:\temp\clean_sociolla_cosrx_products.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

-- Menampilkan isi table cosrx_products
SELECT * FROM cosrx_products;


-- Normalisasi
-- Uji 1NF
/*
Rules:
- Setiap cell hanya mengandung 1 value
- Setiap records harus unik
- Ada yang bisa dijadikan primary key/attribute key (kolom id atau nama_produk bisa dijadikan primary key)
*/
SELECT 	COUNT(*) FILTER (
		WHERE nama_produk IS NULL 
		OR harga_produk IS NULL 
		OR rating IS NULL 
		OR jumlah_produk_terjual IS NULL) AS null_values,
COUNT(DISTINCT nama_produk) AS unique_product_names,
COUNT(*) AS total_rows
FROM cosrx_products;
-- null_values = 0 ; unique_product_names = total_rows = 112; 1NF terpenuhi.

-- Uji 2NF
/*
Rules:
- Sudah sesuai dengan rules 1NF
- Semua atribut non-key harus bergantung pada primary key (tidak ada partial dependencies)
*/
SELECT 	nama_produk,
       	COUNT(DISTINCT harga_produk) AS variasi_harga,
       	COUNT(DISTINCT rating) AS variasi_rating
FROM cosrx_products
GROUP BY nama_produk
HAVING COUNT(DISTINCT harga_produk) > 1 OR COUNT(DISTINCT rating) > 1;
-- hasil query kosong -> tidak ada partal dependencies -> 2NF terpenuhi.

-- Uji 3NF
/*
Rules:
- Sudah sesuai dengan rules 2NF
- dalam tabel tidak boleh ada transitive functional dependencies (semua atribut non-key harus bergantung pada primary key dan hanya pada primary key)
*/
SELECT rating, COUNT(DISTINCT jumlah_produk_terjual) AS variasi_penjualan
FROM cosrx_products
GROUP BY rating
HAVING COUNT(DISTINCT jumlah_produk_terjual) > 1;
-- hasil query berisi beberapa rating dengan variasi penjualan yang berbeda -> tidak ada transitive functional dependency non-key -> 3NF terpenuhi.