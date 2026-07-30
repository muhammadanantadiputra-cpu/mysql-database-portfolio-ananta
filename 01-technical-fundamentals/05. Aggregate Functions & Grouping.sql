USE porto_ananta;

-- 1. Aggregate Functions Dasar
SELECT COUNT(id) AS 'Total Product' FROM products;
SELECT AVG(price) AS 'Rata-Rata Harga' FROM products;
SELECT MAX(price) AS 'Harga Termahal' FROM products;
SELECT MIN(price) AS 'Harga Termurah' FROM products;
SELECT SUM(quantity) AS 'Total Stok' FROM products;

-- 2. Pengelompokan Data (GROUP BY)
SELECT category, COUNT(id) AS 'Total Product' 
FROM products 
GROUP BY category;

SELECT category, AVG(price) AS 'Rata-Rata Harga' 
FROM products 
GROUP BY category;

-- 3. Filtering Hasil Agregasi (HAVING Clause)
-- Menampilkan kategori yang memiliki total produk lebih dari 1
SELECT category, COUNT(id) AS total 
FROM products 
GROUP BY category 
HAVING total > 1;

-- Menampilkan kategori dengan rata-rata harga diatas 15000
SELECT category, AVG(price) AS rata_rata 
FROM products 
GROUP BY category 
HAVING rata_rata > 15000;
