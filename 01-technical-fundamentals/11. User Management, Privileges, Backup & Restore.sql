USE porto_ananta;

-- 1. Membuat User Baru
CREATE USER 'nata'@'localhost';
CREATE USER 'putra'@'%';

-- 2. Pengaturan Password User
SET PASSWORD FOR 'nata'@'localhost' = 'rahasia';
SET PASSWORD FOR 'putra'@'%' = 'rahasia';

-- 3. Menambahkan Hak Akses (GRANT)
GRANT SELECT ON belajar_mysql.* TO 'nata'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE 
ON belajar_mysql.* TO 'putra'@'%';

-- 4. Melihat & Mencabut Hak Akses (SHOW GRANTS & REVOKE)
SHOW GRANTS FOR 'nata'@'localhost';

REVOKE INSERT, UPDATE, DELETE 
ON belajar_mysql.* FROM 'putra'@'%';

-- 5. Menghapus User
DROP USER 'nata'@'localhost';
DROP USER 'putra'@'%';

-- ===================================================
-- PERINDAH TERMINAL / COMMAND PROMPT (BUKAN DI DBCONSOLE)
-- ===================================================

-- BACKUP DATABASE VIA TERMINAL:
-- mysqldump -u root -p belajar_mysql > /path/to/backup_belajar_mysql.sql

-- RESTORE DATABASE VIA TERMINAL:
-- mysql -u root -p belajar_mysql < /path/to/backup_belajar_mysql.sql
