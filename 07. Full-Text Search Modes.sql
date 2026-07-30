USE porto_ananta;

-- 1. Menambahkan Full-Text Index ke Tabel Products
ALTER TABLE products 
ADD FULLTEXT product_search (name, description);

-- Menghapus Full-Text Index
-- ALTER TABLE products DROP INDEX product_search;

-- 2. Mode 1: Natural Language Mode
SELECT * FROM products 
WHERE MATCH(name, description) 
      AGAINST('ayam' IN NATURAL LANGUAGE MODE);

-- 3. Mode 2: Boolean Mode (Menggunakan Operator + dan -)
-- Mencari yang mengandung kata 'mie' TAPI TIDAK mengandung kata 'bakso'
SELECT * FROM products 
WHERE MATCH(name, description) 
      AGAINST('+mie -bakso' IN BOOLEAN MODE);

-- 4. Mode 3: Query Expansion Mode
-- Melakukan 2 kali pencarian otomatis berdasarkan kedekatan relasi kata
SELECT * FROM products 
WHERE MATCH(name, description) 
      AGAINST('bakso' WITH QUERY EXPANSION);
