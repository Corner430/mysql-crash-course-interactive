-- ========================================
-- MySQL Crash Course - Database Setup Script
-- ========================================

-- Drop database if exists
DROP DATABASE IF EXISTS crashcourse;

-- Create database
CREATE DATABASE crashcourse CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use database
USE crashcourse;

-- ========================================
-- Create Tables
-- ========================================

-- Vendors table
CREATE TABLE vendors (
  vend_id      INT          NOT NULL AUTO_INCREMENT,
  vend_name    VARCHAR(50)  NOT NULL,
  vend_address VARCHAR(50)  NULL,
  vend_city    VARCHAR(50)  NULL,
  vend_state   CHAR(5)      NULL,
  vend_zip     VARCHAR(10)  NULL,
  vend_country VARCHAR(50)  NULL,
  PRIMARY KEY (vend_id)
) ENGINE=InnoDB;

-- Products table
CREATE TABLE products (
  prod_id    CHAR(10)      NOT NULL,
  vend_id    INT           NOT NULL,
  prod_name  VARCHAR(255)  NOT NULL,
  prod_price DECIMAL(8,2)  NOT NULL,
  prod_desc  TEXT          NULL,
  PRIMARY KEY (prod_id),
  FOREIGN KEY (vend_id) REFERENCES vendors(vend_id)
) ENGINE=InnoDB;

-- Customers table
CREATE TABLE customers (
  cust_id      INT          NOT NULL AUTO_INCREMENT,
  cust_name    VARCHAR(50)  NOT NULL,
  cust_address VARCHAR(50)  NULL,
  cust_city    VARCHAR(50)  NULL,
  cust_state   CHAR(5)      NULL,
  cust_zip     VARCHAR(10)  NULL,
  cust_country VARCHAR(50)  NULL,
  cust_contact VARCHAR(50)  NULL,
  cust_email   VARCHAR(255) NULL,
  PRIMARY KEY (cust_id)
) ENGINE=InnoDB;

-- Orders table
CREATE TABLE orders (
  order_num  INT      NOT NULL AUTO_INCREMENT,
  order_date DATETIME NOT NULL,
  cust_id    INT      NOT NULL,
  PRIMARY KEY (order_num),
  FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
) ENGINE=InnoDB;

-- Order items table
CREATE TABLE orderitems (
  order_num  INT           NOT NULL,
  order_item INT           NOT NULL,
  prod_id    CHAR(10)      NOT NULL,
  quantity   INT           NOT NULL,
  item_price DECIMAL(8,2)  NOT NULL,
  PRIMARY KEY (order_num, order_item),
  FOREIGN KEY (order_num) REFERENCES orders(order_num),
  FOREIGN KEY (prod_id) REFERENCES products(prod_id)
) ENGINE=InnoDB;

-- Product notes table (for fulltext search examples)
CREATE TABLE productnotes (
  note_id    INT           NOT NULL AUTO_INCREMENT,
  prod_id    CHAR(10)      NOT NULL,
  note_date  DATETIME      NOT NULL,
  note_text  TEXT          NULL,
  PRIMARY KEY (note_id),
  FULLTEXT(note_text)
) ENGINE=MyISAM;

-- ========================================
-- Insert Sample Data
-- ========================================

-- Insert vendors
INSERT INTO vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES
  (1001, 'Anvils R Us', '123 Main Street', 'Southfield', 'MI', '48075', 'USA'),
  (1002, 'LT Supplies', '500 Park Street', 'Anytown', 'OH', '44333', 'USA'),
  (1003, 'ACME', '555 High Street', 'Los Angeles', 'CA', '90046', 'USA'),
  (1004, 'Furball Inc.', '1000 5th Avenue', 'New York', 'NY', '11111', 'USA'),
  (1005, 'Jet Set', '42 Galaxy Road', 'London', NULL, 'N16 6PS', 'England'),
  (1006, 'Jouets Et Ours', '1 Rue Amusement', 'Paris', NULL, '45678', 'France');

-- Insert products
INSERT INTO products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES
  ('ANV01', 1001, '.5 ton anvil', 5.99, '.5 ton anvil, black, complete with handy hook'),
  ('ANV02', 1001, '1 ton anvil', 9.99, '1 ton anvil, black, complete with handy hook and carrying case'),
  ('ANV03', 1001, '2 ton anvil', 14.99, '2 ton anvil, black, complete with handy hook and carrying case'),
  ('OL1', 1002, 'Oil can', 8.99, 'Oil can, red'),
  ('FU1', 1002, 'Fuses', 3.42, '1 dozen, extra long'),
  ('SLING', 1003, 'Sling', 4.49, 'Sling, one size fits all'),
  ('TNT1', 1003, 'TNT (1 stick)', 2.50, 'TNT, red, single stick'),
  ('TNT2', 1003, 'TNT (5 sticks)', 10.00, 'TNT, red, pack of 5 sticks'),
  ('FB', 1003, 'Bird seed', 10.00, 'Large bag (suitable for road runners)'),
  ('FC', 1003, 'Carrots', 2.50, 'Carrots (rabbit hunting season only)'),
  ('SAFE', 1003, 'Safe', 50.00, 'Safe with combination lock'),
  ('DTNTR', 1003, 'Detonator', 13.00, 'Detonator (plunger powered), fuses not included'),
  ('JP1000', 1005, 'JetPack 1000', 35.00, 'JetPack 1000, intended for single use'),
  ('JP2000', 1005, 'JetPack 2000', 55.00, 'JetPack 2000, multi-use');

-- Insert customers
INSERT INTO customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES
  (10001, 'Coyote Inc.', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'Y Lee', 'ylee@coyote.com'),
  (10002, 'Mouse House', '333 Fromage Lane', 'Columbus', 'OH', '43333', 'USA', 'Jerry Mouse', NULL),
  (10003, 'Wascals', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', 'rabbit@wascally.com'),
  (10004, 'Yosemite Place', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Y Sam', 'sam@yosemite.com'),
  (10005, 'E Fudd', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'E Fudd', NULL);

-- Insert orders
INSERT INTO orders(order_num, order_date, cust_id)
VALUES
  (20005, '2005-09-01', 10001),
  (20006, '2005-09-12', 10003),
  (20007, '2005-09-30', 10004),
  (20008, '2005-10-03', 10005),
  (20009, '2005-10-08', 10001);

-- Insert order items
INSERT INTO orderitems(order_num, order_item, prod_id, quantity, item_price)
VALUES
  (20005, 1, 'ANV01', 10, 5.99),
  (20005, 2, 'ANV02', 3, 9.99),
  (20005, 3, 'TNT2', 5, 10.00),
  (20005, 4, 'FB', 1, 10.00),
  (20006, 1, 'JP2000', 1, 55.00),
  (20007, 1, 'TNT2', 100, 10.00),
  (20008, 1, 'FC', 50, 2.50),
  (20009, 1, 'SLING', 1, 4.49),
  (20009, 2, 'ANV03', 1, 14.99);

-- Insert product notes
INSERT INTO productnotes(note_id, prod_id, note_date, note_text)
VALUES
  (101, 'TNT2', '2005-08-17', 'Customer complaint: Sticks not individually wrapped, too easy to mistakenly detonate all at once. Recommend individual wrapping.'),
  (102, 'OL1', '2005-08-18', 'Can shipped full, refills not available. Need to order new can if refill needed.'),
  (103, 'SAFE', '2005-08-18', 'Safe is combination locked, combination not provided with safe. This is rarely a problem as safes are typically blown up or dropped by customers.'),
  (104, 'FC', '2005-08-19', 'Quantity varies, sold by the sack load. All guaranteed to be bright and orange, and suitable for use as rabbit bait.'),
  (105, 'TNT2', '2005-08-20', 'Included fuses are short and have been known to detonate too quickly for some customers. Longer fuses are available (item FU1) and should be recommended.'),
  (106, 'TNT2', '2005-08-22', 'Matches not included, recommend purchase of matches or detonator (item DTNTR).'),
  (107, 'SAFE', '2005-08-23', 'Please note that no returns will be accepted if safe opened using explosives.'),
  (108, 'ANV01', '2005-08-25', 'Multiple customer returns, anvils failing to drop fast enough or falling backwards on purchaser. Recommend that customer considers using heavier anvils.'),
  (109, 'ANV03', '2005-09-01', 'Item is extremely heavy. Designed for dropping, not recommended for use with slings, ropes, pulleys, or tightropes.'),
  (110, 'FC', '2005-09-01', 'Customer complaint: rabbit has been able to detect trap, food apparently less effective now.'),
  (111, 'SLING', '2005-09-02', 'Shipped unassembled, requires common tools (including oversized hammer).'),
  (112, 'SAFE', '2005-09-02', 'Customer complaint: Circular hole in safe floor can apparently be easily cut with handsaw.'),
  (113, 'ANV01', '2005-09-05', 'Customer complaint: Not heavy enough to generate flying stars around head of victim. If being purchased for dropping, recommend ANV02 or ANV03 instead.'),
  (114, 'SAFE', '2005-09-07', 'Call from individual trapped in safe plummeting to the ground, suggests an escape hatch be added. Comment forwarded to vendor.');

-- ========================================
-- Display Summary
-- ========================================

SELECT 'Database initialized successfully!' AS Status;
SELECT 'Created tables:' AS Info;
SHOW TABLES;

SELECT 'Data summary:' AS Info;
SELECT 'vendors' AS TableName, COUNT(*) AS Records FROM vendors
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'orderitems', COUNT(*) FROM orderitems
UNION ALL
SELECT 'productnotes', COUNT(*) FROM productnotes;

SELECT 'You can now start learning! Use: USE crashcourse;' AS Tip;
