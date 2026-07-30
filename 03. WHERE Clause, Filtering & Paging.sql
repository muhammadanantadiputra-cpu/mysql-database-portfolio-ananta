USE porto_ananta;

-- 1. Operator Perbandingan
SELECT id, name, price, quantity 
FROM products 
WHERE quantity > 100;

SELECT id, name, price 
FROM products 
WHERE price <= 20000;

SELECT id, name 
FROM products 
WHERE category != 'Makanan';

-- 2. Operator Logika (AND, OR, Priority Kurung)
-- Operator AND
SELECT id, name, price, quantity 
FROM products 
WHERE quantity > 10 AND price > 15000;

-- Operator OR
SELECT id, name, price, quantity 
FROM products 
WHERE quantity > 500 OR price > 20000;

-- Prioritas dengan Kurung ()
SELECT id, name, price, quantity 
FROM products 
WHERE (category = 'Makanan' OR quantity > 50) 
  AND price > 10000;

-- 3. Operator LIKE (Pencarian Pola String)
SELECT * FROM products WHERE name LIKE '%mie%';
SELECT * FROM products WHERE name LIKE 'Mie%';
SELECT * FROM products WHERE name LIKE '%Bakso';

-- 4. Operator NULL
SELECT * FROM products WHERE description IS NULL;
SELECT * FROM products WHERE description IS NOT NULL;

-- 5. Operator BETWEEN (Rentang Nilai)
SELECT * FROM products 
WHERE price BETWEEN 10000 AND 20000;

SELECT * FROM products 
WHERE price NOT BETWEEN 10000 AND 20000;

-- 6. Operator IN (Pencarian Banyak Nilai)
SELECT * FROM products 
WHERE category IN ('Makanan', 'Minuman');

-- 7. Pengurutan Data (ORDER BY)
SELECT * FROM products 
ORDER BY price ASC, id DESC;

-- 8. Pembatasan Hasil Query (LIMIT & OFFSET / Paging)
-- Ambil 2 data pertama
SELECT * FROM products 
WHERE price > 0 
ORDER BY price 
LIMIT 2;

-- Skip 2 data pertama, lalu ambil 2 data berikutnya (Page 2)
SELECT * FROM products 
WHERE price > 0 
ORDER BY price 
LIMIT 2, 2;
