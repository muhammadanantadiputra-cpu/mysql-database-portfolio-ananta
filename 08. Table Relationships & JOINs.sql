USE porto_ananta;

-- 1. Foreign Key & Foreign Key Behavior (CASCADE / RESTRICT)
CREATE TABLE wishlist (
    id INT NOT NULL AUTO_INCREMENT,
    id_product VARCHAR(10) NOT NULL,
    description TEXT,
    PRIMARY KEY (id),
    CONSTRAINT fk_wishlist_product 
        FOREIGN KEY (id_product) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- 2. RELASI ONE TO ONE (Customers <-> Wallet)
CREATE TABLE wallet (
    id INT NOT NULL AUTO_INCREMENT,
    id_customer INT NOT NULL,
    balance INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY fk_id_customer_unique (id_customer),
    CONSTRAINT fk_wallet_customer 
        FOREIGN KEY (id_customer) REFERENCES customers (id)
) ENGINE = InnoDB;

-- 3. RELASI ONE TO MANY (Categories <-> Products)
CREATE TABLE categories (
    id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

ALTER TABLE products ADD COLUMN id_category VARCHAR(10);
ALTER TABLE products 
ADD CONSTRAINT fk_product_category 
FOREIGN KEY (id_category) REFERENCES categories (id);

-- 4. RELASI MANY TO MANY (Products <-> Orders via Orders Detail)
CREATE TABLE orders (
    id INT NOT NULL AUTO_INCREMENT,
    total INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

CREATE TABLE orders_detail (
    id_product VARCHAR(10) NOT NULL,
    id_order INT NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (id_product, id_order),
    CONSTRAINT fk_orders_detail_product FOREIGN KEY (id_product) REFERENCES products(id),
    CONSTRAINT fk_orders_detail_order FOREIGN KEY (id_order) REFERENCES orders(id)
) ENGINE = InnoDB;

-- 5. OPERASI JOIN TABEL
-- INNER JOIN (Default)
SELECT * FROM categories 
INNER JOIN products ON (products.id_category = categories.id);

-- LEFT JOIN (Mengambil seluruh data tabel kiri meskipun tidak ada di tabel kanan)
SELECT * FROM categories 
LEFT JOIN products ON (products.id_category = categories.id);

-- RIGHT JOIN (Mengambil seluruh data tabel kanan)
SELECT * FROM categories 
RIGHT JOIN products ON (products.id_category = categories.id);

-- CROSS JOIN (Perkalian Kombinasi Data)
SELECT * FROM categories CROSS JOIN products;
