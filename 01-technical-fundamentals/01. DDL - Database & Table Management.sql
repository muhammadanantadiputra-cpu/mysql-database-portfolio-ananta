-- 1. Manajemen Database
SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS porto_ananta;

USE porto_ananta;

-- 2. Membuat Tabel Sederhana (Barang)
CREATE TABLE barang (
    kode INT,
    nama VARCHAR(100),
    harga INT,
    jumlah INT
) ENGINE = InnoDB;

-- 3. Melihat Struktur Tabel
DESCRIBE barang;
DESC barang;
SHOW CREATE TABLE barang;

-- 4. Mengubah Struktur Tabel (ALTER TABLE)
-- Menambah kolom baru
ALTER TABLE barang 
ADD COLUMN deskripsi TEXT;

-- Menghapus kolom
ALTER TABLE barang 
DROP COLUMN deskripsi;

-- Mengubah nama kolom
ALTER TABLE barang 
RENAME COLUMN nama TO nama_barang;

-- Mengubah posisi & tipe data kolom
ALTER TABLE barang 
MODIFY nama_barang VARCHAR(100) AFTER jumlah;

ALTER TABLE barang 
MODIFY nama_barang VARCHAR(100) FIRST;

-- 5. Menghapus Isi Tabel & Menghapus Tabel
TRUNCATE TABLE barang;

DROP TABLE IF EXISTS barang;
