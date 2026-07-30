USE porto_ananta;

-- 1. Membuat Tabel Products untuk Latihan DML
CREATE TABLE products (
    id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

-- 2. Memasukkan Data (INSERT)
-- Insert Single Row
INSERT INTO products(id, name, price, quantity)
VALUES ('P0001', 'Mie Ayam Original', 15000, 100);

INSERT INTO products(id, name, description, price, quantity)
VALUES ('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 100);

-- Insert Multiple Rows (Batch Insert)
INSERT INTO products(id, name, price, quantity)
VALUES ('P0003', 'Mie Ayam Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Spesial', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 15000, 100);

-- 3. Mengambil Data (SELECT)
SELECT * FROM products;

SELECT id, name, price, quantity FROM products;

-- 4. Mengubah Data (UPDATE)
-- Update Satu Kolom
UPDATE products
SET category = 'Makanan'
WHERE id = 'P0001';

-- Update Beberapa Kolom
UPDATE products
SET category = 'Makanan',
    description = 'Mie Ayam + Ceker'
WHERE id = 'P0003';

-- Update Menggunakan Kalkulasi Nilai Kolom
UPDATE products
SET price = price + 5000
WHERE id = 'P0004';

-- 5. Menghapus Data (DELETE)
DELETE FROM products 
WHERE id = 'P0009';

-- 6. Menghilangkan Data Duplikat (DISTINCT)
SELECT DISTINCT category FROM products;

-- 7. Penggunaan Alias untuk Kolom dan Tabel
-- Alias Kolom
SELECT id AS 'Kode',
       name AS 'Nama Produk',
       price AS 'Harga Rp',
       quantity AS 'Stok'
FROM products;

-- Alias Tabel
SELECT p.id AS 'Kode',
       p.name AS 'Nama Produk',
       p.price AS 'Harga'
FROM products AS p;
