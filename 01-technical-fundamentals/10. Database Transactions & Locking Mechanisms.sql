-- Penerapan Konsep ACID (Atomicity, Consistency, Isolation, Durability)
-- serta Mekanisme Penguncian (Locking) di MySQL InnoDB

CREATE DATABASE IF NOT EXISTS ananta_belajar_acid;
USE ananta_belajar_acid;

-- SETUP TABEL UNTUK SIMULASI ACID (ACCOUNTS)

CREATE TABLE IF NOT EXISTS accounts (
id VARCHAR(100) NOT NULL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
balance BIGINT NOT NULL
) ENGINE = InnoDB;

-- Clean up data jika ada
TRUNCATE TABLE accounts;

-- 1. ATOMICITY
-- Semua statement dalam transaksi dieksekusi sebagai 1 kesatuan.
-- Jika sukses = COMMIT, jika gagal/dibatalkan = ROLLBACK.

-- Case 1.1: Transaksi Sukses (Commit)
START TRANSACTION;

INSERT INTO accounts (id, name, balance)
VALUES ('eko', 'Eko Kurniawan', 1000000);

INSERT INTO accounts (id, name, balance)
VALUES ('budi', 'Budi Nugraha', 2000000);

COMMIT;

SELECT * FROM accounts;

-- Case 1.2: Transaksi Dibatalkan (Rollback)
START TRANSACTION;

DELETE FROM accounts WHERE id = 'eko';
DELETE FROM accounts WHERE id = 'budi';

-- Batalkan seluruh perubahan di atas
ROLLBACK;

SELECT * FROM accounts;

-- 2. CONSISTENCY
-- Transaksi hanya mengubah data dari satu kondisi valid ke kondisi valid lainnya.
-- Mencegah pelanggaran aturan (constraints) basis data.

START TRANSACTION;

-- Percobaan Update Invalid (Name bertipe NOT NULL diubah jadi NULL)
-- MySQL akan menolak/error sehingga konsistensi data tetap terjaga
UPDATE accounts
SET name = NULL
WHERE id = 'eko';

-- Karena ada error pada aturan data, kita ROLLBACK
ROLLBACK;

SELECT * FROM accounts;

-- 3. ISOLATION & LOCKING (Concurrency Control)
-- Memastikan transaksi yang berjalan bersamaan tidak saling mengganggu
-- Menggunakan Pessimistic Locking (SELECT ... FOR UPDATE)

-- Simulasi Transfer Uang Aman antar Akun
START TRANSACTION;

-- Mengunci baris data 'putra' dan 'nata' agar tidak bisa diubah oleh koneksi/session lain
SELECT * FROM accounts
WHERE id IN ('putra', 'nata') FOR UPDATE;

-- Potong saldo Eko
UPDATE accounts
SET balance = balance - 500000
WHERE id = 'putra';

-- Tambah saldo Budi
UPDATE accounts
SET balance = balance + 500000
WHERE id = 'nata';

COMMIT;

SELECT * FROM accounts;

-- 4. DURABILITY
-- Transaksi yang sudah di-COMMIT akan disimpan secara permanen di disk storage,
-- tetap bertahan meskipun sistem mati/crash. Transaksi yang belum COMMIT
-- akan otomatis di-ROLLBACK oleh MySQL saat restart.

START TRANSACTION;

SELECT * FROM accounts WHERE id IN ('putra', 'nata') FOR UPDATE;

UPDATE accounts
SET balance = balance - 500000
WHERE id = 'putra';

-- Jika sistem mati/shutdown di sini tanpa COMMIT,
-- maka data saldo 'eko' TIDAK akan berubah saat database dinyalakan kembali.
-- (Gunakan ROLLBACK untuk mensimulasikan kegagalan transaksi)
ROLLBACK;

-- 5. MECHANISM LOCKING TABEL & INSTANCE LOCKING

-- Table Locking (READ & WRITE)
LOCK TABLES accounts READ;
SELECT * FROM accounts;
UNLOCK TABLES;

LOCK TABLES accounts WRITE;
UPDATE accounts SET balance = balance + 100000 WHERE id = 'eko';
UNLOCK TABLES;

-- Instance Locking (Biasa digunakan saat proses Backup Database)
LOCK INSTANCE FOR BACKUP;
UNLOCK INSTANCE;
