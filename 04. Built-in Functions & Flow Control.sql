USE porto_ananta;

-- 1. Arithmetic Operators & Mathematical Functions
SELECT 10 + 10 AS hasil_tambah;

SELECT id, price DIV 1000 AS 'Price in K' 
FROM products;

SELECT PI();
SELECT POWER(10, 2) AS pangkat;
SELECT COS(10), SIN(10), TAN(10);

-- 2. String Functions
SELECT id, LOWER(name) AS 'Name Lower' FROM products;
SELECT id, UPPER(name) AS 'Name Upper' FROM products;
SELECT id, name, LENGTH(name) AS 'Name Length' FROM products;

-- 3. Date and Time Functions
SELECT id,
       EXTRACT(YEAR FROM created_at) AS 'Year',
       EXTRACT(MONTH FROM created_at) AS 'Month'
FROM products;

SELECT id, YEAR(created_at), MONTH(created_at) 
FROM products;

-- 4. Flow Control Functions (CASE, IF, IFNULL)
-- Control Flow CASE
SELECT id,
       CASE category
           WHEN 'Makanan' THEN 'Enak'
           WHEN 'Minuman' THEN 'Segar'
           ELSE 'Lain-Lain'
       END AS 'Kategori Keterangan'
FROM products;

-- Control Flow IF
SELECT id,
       price,
       IF(price <= 15000, 'Murah', 
          IF(price <= 20000, 'Mahal', 'Mahal Banget')
       ) AS 'Mahal?'
FROM products;

-- Control Flow IFNULL
SELECT id, name, IFNULL(description, 'Kosong') AS description_clean 
FROM products;
