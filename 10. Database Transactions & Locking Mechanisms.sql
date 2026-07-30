USE porto_ananta;

-- 1. DATABASE TRANSACTION (COMMIT & ROLLBACK)
-- Memulai Transaksi
START TRANSACTION;

INSERT INTO guestbooks (email, title, content)
VALUES ('contoh@gmail.com', 'contoh', 'contoh'),
       ('contoh2@gmail.com', 'contoh2', 'contoh2');

SELECT * FROM guestbooks;

-- Membatalkan Perubahan Transaksi
ROLLBACK;

-- Memulai Transaksi Baru & Menyimpan Permanen
START TRANSACTION;

INSERT INTO guestbooks (email, title, content)
VALUES ('sukses@gmail.com', 'sukses', 'sukses');

-- Menyimpan Permanen Transaksi
COMMIT;

-- 2. LOCKING RECORD MANUAL (SELECT FOR UPDATE)
START TRANSACTION;

SELECT * FROM products 
WHERE id = 'P0001' FOR UPDATE;

-- Update data stok aman dari race condition pengguna lain
UPDATE products 
SET quantity = quantity - 1 
WHERE id = 'P0001';

COMMIT;

-- 3. TABLE LOCKING (READ & WRITE)
-- Lock Table READ (Pengguna lain & kita hanya bisa READ)
LOCK TABLES products READ;
SELECT * FROM products;
UNLOCK TABLES;

-- Lock Table WRITE (Kita bisa READ/WRITE, pengguna lain diminta menunggu)
LOCK TABLES products WRITE;
UPDATE products SET quantity = 100 WHERE id = 'P0001';
UNLOCK TABLES;

-- 4. INSTANCE LOCKING (Berguna saat proses Backup)
LOCK INSTANCE FOR BACKUP;
UNLOCK INSTANCE;
