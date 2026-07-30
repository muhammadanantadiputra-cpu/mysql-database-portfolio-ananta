-- MAIN PROJECT: MULTI-LANGUAGE 
-- Perancangan & Implementasi Skema Basis Data Multi-Bahasa

CREATE DATABASE db_ananta_localization;
USE db_ananta_localization;

-- 1. STRUKTUR TABEL MASTER KATEGORI (UTAMA)
-- Tabel ini menyimpan entitas master tanpa terikat bahasa apapun

CREATE TABLE IF NOT EXISTS categories (
    id VARCHAR(100) NOT NULL,
    position INT NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

-- Clean up data lama jika ada
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE categories;
SET FOREIGN_KEY_CHECKS = 1;

-- Menambahkan data master kategori beserta urutan posisinya
INSERT INTO categories (id, position) VALUES
('FOOD', 1),
('GADGET', 2),
('FASHION', 3);

-- Verifikasi data master berdasarkan urutan posisi
SELECT id, position 
FROM categories 
ORDER BY position ASC;

-- 2. STRUKTUR TABEL TRANSLASI KATEGORI (LOCALIZATION)
-- Menggunakan Entity-Translation Pattern dengan Composite Primary Key (category_id, language)

CREATE TABLE IF NOT EXISTS categories_translations (
    category_id VARCHAR(100) NOT NULL,
    language VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    PRIMARY KEY (category_id, language),
    CONSTRAINT fk_categories_translation
        FOREIGN KEY (category_id) REFERENCES categories (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Clean up data translasi lama jika ada
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE categories_translations;
SET FOREIGN_KEY_CHECKS = 1;

-- Pengisian data penerjemahan (Bahasa Indonesia: in_ID & Bahasa Inggris: en_US)
INSERT INTO categories_translations (category_id, language, name, description) VALUES
-- Makanan / Food
('FOOD', 'in_ID', 'Makanan & Kuliner', 'Kategori berbagai jenis produk makanan dan hidangan lezat'),
('FOOD', 'en_US', 'Food & Culinary', 'Category for various food products and delicious culinary items'),

-- Gawai / Gadget
('GADGET', 'in_ID', 'Gawai & Elektronik', 'Kategori untuk perangkat elektronik, ponsel, dan teknologi'),
('GADGET', 'en_US', 'Gadgets & Electronics', 'Category for electronic devices, smartphones, and tech gear'),

-- Pakaian / Fashion
('FASHION', 'in_ID', 'Pakaian & Mode', 'Kategori produk busana, pakaian pria/wanita, dan aksesori'),
('FASHION', 'en_US', 'Fashion & Apparel', 'Category for apparel products, men/women clothing, and accessories');

-- QUERY ANALITIS & LOKALISASI KONTEN

-- Skenario 1: Menampilkan seluruh kategori dalam Bahasa Indonesia (in_ID)
SELECT 
    c.id AS category_code,
    c.position,
    ct.language,
    ct.name AS category_name,
    ct.description
FROM categories c
JOIN categories_translations ct ON (c.id = ct.category_id)
WHERE ct.language = 'in_ID'
ORDER BY c.position ASC;

-- Skenario 2: Menampilkan seluruh kategori dalam Bahasa Inggris (en_US)
SELECT 
    c.id AS category_code,
    c.position,
    ct.language,
    ct.name AS category_name,
    ct.description
FROM categories c
JOIN categories_translations ct ON (c.id = ct.category_id)
WHERE ct.language = 'en_US'
ORDER BY c.position ASC;

-- Skenario 3: Fallback Query (Mengambil Bahasa Indonesia jika pilihan bahasa tidak tersedia)
SELECT 
    c.id AS category_code,
    c.position,
    COALESCE(ct_pref.name, ct_def.name) AS category_name,
    COALESCE(ct_pref.description, ct_def.description) AS category_description
FROM categories c
LEFT JOIN categories_translations ct_pref ON (c.id = ct_pref.category_id AND ct_pref.language = 'ja_JP') 
LEFT JOIN categories_translations ct_def ON (c.id = ct_def.category_id AND ct_def.language = 'in_ID')  
ORDER BY c.position ASC;
