MySQL Database Portfolio - Ananta

Repositori ini berisi dokumentasi latihan SQL dan proyek perancangan basis data relasional menggunakan MySQL. Seluruh skrip disusun sebagai bagian dari portofolio teknis untuk menunjukkan pemahaman dari dasar sintaks SQL hingga perancangan skema database berbasis studi kasus.

Struktur Repositori

Repositori ini dibagi menjadi dua folder utama:

01-technical-fundamentals/: Latihan dasar sintaks dan fitur MySQL (DDL, DML, filtering, agregasi, JOIN, transaksi, user management).

02-main-projects/: Perancangan skema database studi kasus nyata (e-commerce order history, notification system, multi-language engine).

1. Core Technical Fundamentals (/01-technical-fundamentals)

Folder ini berisi 11 skrip latihan yang mendokumentasikan pemahaman sintaks SQL secara bertahap:

01_ddl_database_and_tables.sql: Pembuatan database, tabel, manipulasi struktur tabel (ALTER TABLE), serta penentuan tipe data.

02_dml_crud_operations.sql: Operasi dasar CRUD (INSERT, SELECT, UPDATE, DELETE), penggunaan alias, dan penanganan data unik (DISTINCT).

03_where_operators_filtering.sql: Penyaringan data dengan operator logika, pencarian string (LIKE), rentang nilai (BETWEEN), filter NULL, pengurutan, dan pagination.

04_string_numeric_date_functions.sql: Penggunaan fungsi bawaan untuk manipulasi teks, tanggal, fungsi matematika, serta percabangan (CASE, IF, IFNULL).

05_aggregate_and_grouping.sql: Fungsi agregasi (COUNT, SUM, AVG, MAX, MIN), pengelompokan data (GROUP BY), dan filtering hasil agregat (HAVING).

06_table_constraints_and_indexes.sql: Penerapan constraint (UNIQUE, CHECK, AUTO_INCREMENT) serta penggunaan B-Tree Index untuk optimasi pencarian.

07_fulltext_search_modes.sql: Penggunaan Full-Text Index menggunakan Natural Language Mode, Boolean Mode, dan Query Expansion.

08_table_relationships_and_joins.sql: Penerapan relasi tabel (One-to-One, One-to-Many, Many-to-Many), penanganan Foreign Key behavior, dan variasi operasi JOIN.

09_subqueries_and_set_operators.sql: Subquery pada klausa WHERE dan FROM, serta simulasi operator himpunan (UNION, INTERSECT, MINUS).

10_transactions_and_locking.sql: Penggunaan transaksi database (COMMIT, ROLLBACK) dan mekanisme locking untuk menjaga konsistensi data.

11_user_management_backup_restore.sql: Manajemen user, hak akses (GRANT/REVOKE), serta perintah backup dan restore database melalui terminal CLI.

2. Main Projects (/02-main-projects)

Folder ini berisi perancangan skema database untuk tiga studi kasus nyata:

1. E-Commerce Order History System

Perancangan struktur riwayat transaksi e-commerce. Skema ini dibuat agar data historis pesanan (seperti harga barang dan alamat) tidak berubah meskipun master data produk atau profil pembeli diubah di kemudian hari (data snapshot).

2. Notification Engine Schema

Perancangan sistem notifikasi untuk aplikasi. Mengatur pemisahan antara template notifikasi global dan status dibaca/belum dibaca per pengguna agar kapasitas penyimpanan database tetap efisien.

3. Multi-Language Localization Engine

Perancangan skema database untuk mendukung aplikasi multi-bahasa. Menggunakan pola entity-translation sehingga penambahan bahasa baru tidak merusak struktur tabel utama.
