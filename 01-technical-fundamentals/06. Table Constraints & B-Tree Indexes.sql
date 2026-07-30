USE porto_ananta;

-- 1. AUTO_INCREMENT & LAST_INSERT_ID()
CREATE TABLE admin (
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO admin(first_name, last_name) 
VALUES ('Eko', 'Khannedy'),
       ('Budi', 'Nugraha'),
       ('Joko', 'Morro');

SELECT LAST_INSERT_ID();

-- 2. UNIQUE CONSTRAINT
CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    PRIMARY KEY (id),
    UNIQUE KEY email_unique (email)
) ENGINE = InnoDB;

-- Menambah & Menghapus Unique Constraint via ALTER TABLE
ALTER TABLE customers ADD CONSTRAINT email_unique UNIQUE (email);
ALTER TABLE customers DROP CONSTRAINT email_unique;

-- 3. CHECK CONSTRAINT
ALTER TABLE products 
ADD CONSTRAINT price_check CHECK (price >= 1000);

-- Menghapus Check Constraint
ALTER TABLE products DROP CONSTRAINT price_check;

-- 4. B-TREE INDEX OPTIMIZATION
CREATE TABLE sellers (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY email_unique (email),
    INDEX name_index (name)
) ENGINE = InnoDB;

-- Menambah & Menghapus Index via ALTER TABLE
ALTER TABLE sellers ADD INDEX name_index (name);
ALTER TABLE sellers DROP INDEX name_index;
