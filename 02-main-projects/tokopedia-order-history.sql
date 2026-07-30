-- MAIN PROJECT: E-COMMERCE ORDER HISTORY SYSTEM
-- Perancangan Skema Transaksi & Historical Order Snapshot

CREATE DATABASE db_ananta_ecommerce;
USE db_ananta_ecommerce;

-- 1. TABEL HEADERS TRANSAKSI / ORDERS
CREATE TABLE IF NOT EXISTS orders (
    id VARCHAR(100) PRIMARY KEY,
    seller_id VARCHAR(100) NOT NULL,
    seller_name VARCHAR(100) NOT NULL,
    buyer_id VARCHAR(100) NOT NULL,
    buyer_name VARCHAR(100) NOT NULL,
    shipping_name VARCHAR(100) NOT NULL,
    shipping_address VARCHAR(500) NOT NULL,
    shipping_phone VARCHAR(25) NOT NULL,
    logistic_id VARCHAR(100) NOT NULL,
    logistic_name VARCHAR(100) NOT NULL,
    payment_method_id VARCHAR(100) NOT NULL,
    payment_method_name VARCHAR(100) NOT NULL,
    total_quantity INT NOT NULL,
    total_weight INT NOT NULL,
    total_product_amount BIGINT NOT NULL,
    total_shipping_cost BIGINT NOT NULL,
    total_shopping_amount BIGINT NOT NULL,
    service_charge BIGINT NOT NULL,
    total_amount BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

-- 2. TABEL DETAIL TRANSAKSI / ORDER DETAILS
CREATE TABLE IF NOT EXISTS order_details (
    id VARCHAR(100) PRIMARY KEY,
    order_id VARCHAR(100) NOT NULL,
    product_id VARCHAR(100) NOT NULL,
    product_name VARCHAR(250) NOT NULL,
    product_weight INT NOT NULL,
    product_price BIGINT NOT NULL,
    quantity INT NOT NULL,
    total_amount BIGINT NOT NULL,
    CONSTRAINT fk_orders_to_order_details 
        FOREIGN KEY (order_id) REFERENCES orders (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Clean up data lama jika ada
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE order_details;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert Data Header Transaksi (Order #122)
INSERT INTO orders (
    id, created_at, seller_id, seller_name, buyer_id, buyer_name, 
    shipping_name, shipping_address, shipping_phone, 
    logistic_id, logistic_name, payment_method_id, payment_method_name, 
    total_quantity, total_weight, total_product_amount, total_shipping_cost, 
    total_shopping_amount, service_charge, total_amount
) VALUES (
    '122', 
    NOW(), 
    'galery_olahraga_indonesia', 
    'Galeri Olahraga Indonesia', 
    'ananta', 
    'Muhammad Ananta', 
    'Nata Putra', 
    'Jalan Sudirman No. 123, Pekanbaru, Riau, 28111', 
    '08123456789', 
    'sicepat', 
    'SiCepat Gokil', 
    'debit_online', 
    'Debit Online', 
    5, 
    5360, 
    508500, 
    60000, 
    568500, 
    1000, 
    569500
);

-- Insert Data Detail Items (Rincian Produk)
INSERT INTO order_details (id, order_id, product_id, product_name, product_weight, product_price, quantity, total_amount)
VALUES ('1', '122', 'p1', 'Basketball', 2300, 177900, 2, 355800);

INSERT INTO order_details (id, order_id, product_id, product_name, product_weight, product_price, quantity, total_amount)
VALUES ('2', '122', 'p2', 'Basketball Warna', 500, 98900, 1, 98900);

INSERT INTO order_details (id, order_id, product_id, product_name, product_weight, product_price, quantity, total_amount)
VALUES ('3', '122', 'p3', 'Pentil Pompa Bola', 54, 9900, 1, 9900);

INSERT INTO order_details (id, order_id, product_id, product_name, product_weight, product_price, quantity, total_amount)
VALUES ('4', '122', 'p4', 'Pompa Bola', 198, 43900, 1, 43900);

-- QUERY ANALITIS & PEMANGGILAN DATA

-- Skenario 1: Mengambil Data Header dan Detail Secara Terpisah (2 Queries)
SELECT * FROM orders WHERE id = '122';
SELECT * FROM order_details WHERE order_id = '122';

-- Skenario 2: Menggabungkan Header & Detail Transaksi dalam 1 Query (JOIN)
SELECT 
    o.id AS order_id,
    o.buyer_name,
    o.seller_name,
    o.logistic_name,
    od.product_name,
    od.product_price,
    od.quantity,
    od.total_amount AS item_total,
    o.total_amount AS grand_total
FROM orders o 
JOIN order_details od ON (o.id = od.order_id) 
WHERE o.id = '122';

-- Skenario 3: Mencari Transaksi dengan Nominal Belanja di Atas Rp 500.000
SELECT * FROM orders WHERE total_amount > 500000;
