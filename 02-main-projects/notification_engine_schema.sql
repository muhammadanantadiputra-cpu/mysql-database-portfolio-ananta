-- MAIN PROJECT: NOTIFICATION ENGINE SCHEMA
-- Perancangan & Implementasi Skema Sistem Notifikasi

CREATE DATABASE db_ananta_notification;
USE db_ananta_notification;

-- 1. STRUKTUR TABEL USER & DATA KONSUMEN

CREATE TABLE IF NOT EXISTS user (
id VARCHAR(100) NOT NULL,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
) ENGINE = InnoDB;

-- Truncate jika ada data lama
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE user;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO user (id, name) VALUES
('ananta', 'Muhammad Ananta'),
('nata', 'Nata Putra'),
('putra', 'Budi Putra');

-- 2. STRUKTUR TABEL KATEGORI NOTIFIKASI

CREATE TABLE IF NOT EXISTS category (
id VARCHAR(100) NOT NULL,
name VARCHAR(100) NOT NULL,
PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO category (id, name) VALUES
('INFO', 'Informasi Sistem'),
('PROMO', 'Penawaran Promo'),
('TRANSACTION', 'Status Transaksi');

-- 3. STRUKTUR TABEL NOTIFIKASI (MASTER & BROADCAST)

CREATE TABLE IF NOT EXISTS notification (
id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
detail TEXT NOT NULL,
create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
user_id VARCHAR(100),
category_id VARCHAR(100),
PRIMARY KEY (id),
CONSTRAINT fk_notification_user
FOREIGN KEY (user_id) REFERENCES user (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_notification_category
FOREIGN KEY (category_id) REFERENCES category (id)
ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Insert Data Notifikasi (Personal & Broadcast Global/NULL user_id)
INSERT INTO notification (title, detail, category_id, user_id, create_at) VALUES
('Pesanan Berhasil', 'Pesanan #INV-2026-001 telah dikonfirmasi.', 'TRANSACTION', 'ananta', CURRENT_TIMESTAMP()),
('Promo Cashback 50%', 'Dapatkan cashback hingga Rp 50.000 hari ini!', 'PROMO', NULL, CURRENT_TIMESTAMP()),
('Pembayaran Sukses', 'Pembayaran tagihan Anda berhasil diproses.', 'TRANSACTION', 'nata', CURRENT_TIMESTAMP()),
('Pembaruan Sistem', 'Sistem akan melakukan pemeliharaan pada pukul 00:00.', 'INFO', NULL, CURRENT_TIMESTAMP()),
('Voucher Spesial Pengguna', 'Selamat Ananta! Anda mendapatkan voucher diskon belanja.', 'PROMO', 'ananta', CURRENT_TIMESTAMP());

-- 4. STRUKTUR TABEL STATUS DIBACA (NOTIFICATION READ)
-- Efisiensi penyimpanan tracking dibaca per user

CREATE TABLE IF NOT EXISTS notification_read (
id INT NOT NULL AUTO_INCREMENT,
is_read BOOLEAN NOT NULL DEFAULT TRUE,
notification_id INT NOT NULL,
user_id VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_notification_read_notification
FOREIGN KEY (notification_id) REFERENCES notification (id)
ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_notification_read_user
FOREIGN KEY (user_id) REFERENCES user (id)
ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Data Notifikasi yang Sudah Dibaca
INSERT INTO notification_read (is_read, notification_id, user_id) VALUES
(TRUE, 2, 'ananta'), 
(TRUE, 2, 'nata'),   
(TRUE, 1, 'ananta'); 


-- QUERY ANALITIS & SKENARIO BISNIS APILIKASI

-- Skenario 1: Menampilkan seluruh notifikasi milik 'ananta' (Personal + Broadcast Global) beserta status dibaca
SELECT
n.id,
n.title,
n.detail,
c.name AS category_name,
n.create_at,
IF(nr.id IS NOT NULL AND nr.is_read = TRUE, 'Dibaca', 'Belum Dibaca') AS status_baca
FROM notification n
LEFT JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id AND nr.user_id = 'ananta')
WHERE (n.user_id = 'ananta' OR n.user_id IS NULL)
ORDER BY n.create_at DESC;

-- Skenario 2: Menampilkan notifikasi spesifik kategori 'INFO' untuk user 'nata'
SELECT
n.id,
n.title,
n.detail,
c.name AS category_name,
n.create_at
FROM notification n
JOIN category c ON (n.category_id = c.id)
WHERE (n.user_id = 'nata' OR n.user_id IS NULL)
AND c.id = 'INFO'
ORDER BY n.create_at DESC;

-- Skenario 3: Menhitung jumlah notifikasi belum dibaca (Unread Counter) untuk user 'ananta'
SELECT COUNT(*) AS unread_notification_count
FROM notification n
LEFT JOIN notification_read nr ON (nr.notification_id = n.id AND nr.user_id = 'ananta')
WHERE (n.user_id = 'ananta' OR n.user_id IS NULL)
AND nr.id IS NULL;
