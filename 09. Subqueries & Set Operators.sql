USE porto_ananta;

-- 1. Subquery di WHERE Clause
-- Mencari produk yang harganya di atas rata-rata harga produk
SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);

-- 2. Subquery di FROM Clause
SELECT MAX(price) 
FROM (
    SELECT price FROM categories 
    INNER JOIN products ON (products.id_category = categories.id)
) AS cp;

-- 3. Tabel Guestbooks untuk Latihan Set Operators
CREATE TABLE guestbooks (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

-- 4. UNION Operator (Menggabungkan 2 Query & Menghapus Duplikasi)
SELECT DISTINCT email FROM customers
UNION
SELECT DISTINCT email FROM guestbooks;

-- 5. UNION ALL Operator (Menggabungkan 2 Query + Menampilkan Duplikasi)
SELECT DISTINCT email FROM customers
UNION ALL
SELECT DISTINCT email FROM guestbooks;

-- 6. Simulasi INTERSECT di MySQL (Irisan Dua Query)
SELECT DISTINCT customers.email 
FROM customers
INNER JOIN guestbooks ON (guestbooks.email = customers.email);

-- 7. Simulasi MINUS di MySQL (Query A dikurangi Query B)
SELECT DISTINCT customers.email, guestbooks.email 
FROM customers
LEFT JOIN guestbooks ON (guestbooks.email = customers.email)
WHERE guestbooks.email IS NULL;
