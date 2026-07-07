
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `parent_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`)
) 


INSERT INTO `categories` VALUES (1,'Electronics','Electronic gadgets and devices',NULL,'2026-06-10 17:24:43'),(2,'Footwear','Shoes, sandals and boots',NULL,'2026-06-10 17:24:43'),(3,'Clothing','Shirts, pants and accessories',NULL,'2026-06-10 17:24:43'),(4,'Stationery','Notebooks, pens and supplies',NULL,'2026-06-10 17:24:43'),(5,'Mobile Phones','Smartphones and accessories',1,'2026-06-10 17:24:43'),(6,'Laptops','Laptops and accessories',1,'2026-06-10 17:24:43'),(7,'Running','Running and sports shoes',2,'2026-06-10 17:24:43'),(8,'Casual','Casual wear and t-shirts',3,'2026-06-10 17:24:43'),(9,'Electronics','Electronic gadgets and devices',NULL,'2026-06-10 17:25:07'),(10,'Footwear','Shoes, sandals and boots',NULL,'2026-06-10 17:25:07'),(11,'Clothing','Shirts, pants and accessories',NULL,'2026-06-10 17:25:07'),(12,'Stationery','Notebooks, pens and supplies',NULL,'2026-06-10 17:25:07'),(13,'Mobile Phones','Smartphones and accessories',1,'2026-06-10 17:25:07'),(14,'Laptops','Laptops and accessories',1,'2026-06-10 17:25:07'),(15,'Running','Running and sports shoes',2,'2026-06-10 17:25:07'),(16,'Casual','Casual wear and t-shirts',3,'2026-06-10 17:25:07');
-- Table structure for table `coupons`
--


CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `discount_pct` decimal(5,2) NOT NULL,
  `min_order_amt` decimal(10,2) DEFAULT '0.00',
  `max_uses` int DEFAULT '100',
  `used_count` int DEFAULT '0',
  `expiry_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `code` (`code`)
) 

INSERT INTO `coupons` VALUES (1,'SAVE10',10.00,500.00,100,0,'2024-12-31',1,'2026-06-10 17:24:53'),(2,'OFF20',20.00,1000.00,50,0,'2024-12-25',1,'2026-06-10 17:24:53'),(3,'FLAT50',50.00,2000.00,20,0,'2024-11-30',0,'2026-06-10 17:24:53'),(4,'NEW15',15.00,300.00,200,0,'2025-01-31',1,'2026-06-10 17:24:53');


--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `item_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
)
  

INSERT INTO `orderitems` VALUES (1,1,1,1,599.00),(2,1,2,1,1299.00),(3,2,4,1,1999.00),(4,3,5,1,499.00),(5,4,3,1,89.00);


--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_date` int DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `total` int DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) 



INSERT INTO `orders` VALUES (1,1,NULL,'delivered',1898),(2,2,NULL,'shipped',1999),(3,3,NULL,'placed',499),(4,1,NULL,'delivered',89);


--
-- Table structure for table `payments`
--
CREATE TABLE `payments` (
  `payment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `method` enum('credit_card','debit_card','upi','cod') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `paid_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) 
--
-- Dumping data for table `payments`
--


INSERT INTO `payments` VALUES (1,1,'credit_card',1898.00,'2026-06-10 16:35:13'),(2,2,'upi',1999.00,'2026-06-10 16:35:13'),(3,3,'cod',499.00,'2026-06-10 16:35:13'),(4,4,'debit_card',89.00,'2026-06-10 16:35:13');


--
-- Table structure for table `product`
--
CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `stock_qty` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) 

--
-- Dumping data for table `product`
--

INSERT INTO `product` VALUES (1,'Wireless Mouse','Electronics','50'),(2,'Running Shoes','Footwear','30'),(3,'Notebook 200pg','Stationery','200'),(4,'Bluetooth Speaker','Electronics','20'),(5,'Cotton T-Shirt','Clothing','100');


--
-- Table structure for table `reviews`
--


CREATE TABLE `reviews` (
  `review_id` int NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` tinyint DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `reviews_chk_1` CHECK ((`rating` between 1 and 5))
)

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` VALUES (1,1,1,5,'Excellent mouse, very smooth!'),(2,2,1,4,'Comfortable but slightly tight.'),(3,4,2,5,'Great sound quality!'),(4,5,3,3,'Decent quality for the price.');

--
-- Table structure for table `shipments`
--


CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `tracking_number` varchar(100) DEFAULT NULL,
  `carrier` varchar(100) DEFAULT NULL,
  `status` enum('processing','dispatched','in_transit','delivered','returned') DEFAULT 'processing',
  `shipped_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`shipment_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
)

--
-- Dumping data for table `shipments`
--

INSERT INTO `shipments` VALUES (1,1,'TRK123456','FedEx','delivered','2024-12-20 00:00:00','2024-12-25 00:00:00','2026-06-10 17:25:07'),(2,2,'TRK789012','Delhivery','in_transit','2024-12-22 00:00:00',NULL,'2026-06-10 17:25:07'),(3,3,'TRK345678','BlueDart','processing',NULL,NULL,'2026-06-10 17:25:07'),(4,4,'TRK901234','DTDC','delivered','2024-12-18 00:00:00','2024-12-20 00:00:00','2026-06-10 17:25:07'),(5,1,'TRK123456','FedEx','delivered','2024-12-20 00:00:00','2024-12-25 00:00:00','2026-06-10 17:25:40'),(6,2,'TRK789012','Delhivery','in_transit','2024-12-22 00:00:00',NULL,'2026-06-10 17:25:40'),(7,3,'TRK345678','BlueDart','processing',NULL,NULL,'2026-06-10 17:25:40'),(8,4,'TRK901234','DTDC','delivered','2024-12-18 00:00:00','2024-12-20 00:00:00','2026-06-10 17:25:40');


--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(15) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) 

INSERT INTO `user` VALUES (1,'abinesh','abinesh@gmail.com','2993074878','chennai'),(2,'siva','siva@gmail.com','8793937078','Madurai'),(3,'kishmu','kishmu@gmail.com','9345678321','salem'),(4,'prakash','prakash@gmail.com','9344032128','cuddalore');


--
-- Table structure for table `wishlist`
--


CREATE TABLE `wishlist` (
  `wishlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `added_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wishlist_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
)

--
-- Dumping data for table `wishlist`
--
INSERT INTO `wishlist` VALUES (1,1,4,'2026-06-10 17:25:02'),(2,1,5,'2026-06-10 17:25:02'),(3,2,1,'2026-06-10 17:25:02'),(4,2,2,'2026-06-10 17:25:02'),(5,3,3,'2026-06-10 17:25:02'),(6,4,4,'2026-06-10 17:25:02'),(7,1,4,'2026-06-10 17:25:07'),(8,1,5,'2026-06-10 17:25:07'),(9,2,1,'2026-06-10 17:25:07'),(10,2,2,'2026-06-10 17:25:07'),(11,3,3,'2026-06-10 17:25:07'),(12,4,4,'2026-06-10 17:25:07');



-- Category Performance Report--
SELECT
    c.category_id,
    c.name AS category_name,
    COUNT(*) AS total_products
FROM categories c
GROUP BY c.category_id, c.name
ORDER BY total_products DESC;

SELECT 
    u.name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty * oi.unit_price) AS total_revenue,
    AVG(oi.qty * oi.unit_price) AS average_order_value
FROM user u
JOIN orders o
    ON u.user_id = o.user_id
JOIN orderitems oi
    ON o.order_id = oi.order_id
GROUP BY u.user_id, u.name
HAVING SUM(oi.qty * oi.unit_price) > 1000
ORDER BY total_revenue DESC;


-- Shipment Status Report--
SELECT 
    s.status,
    COUNT(*) AS shipment_count
FROM shipments s
GROUP BY s.status
ORDER BY shipment_count DESC;


-- Customer Purchase Report--
SELECT 
    u.user_id,
    u.name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.qty) AS total_products_purchased,
    SUM(oi.qty * oi.unit_price) AS total_spent
FROM user u
JOIN orders o
    ON u.user_id = o.user_id
JOIN orderitems oi
    ON o.order_id = oi.order_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC;

-- Product Review Analytics--
SELECT 
    product_id,
    COUNT(review_id) AS total_reviews,
    AVG(rating) AS average_rating,
    MAX(rating) AS highest_rating,
    MIN(rating) AS lowest_rating
FROM reviews
GROUP BY product_id
ORDER BY average_rating DESC;


-- Order Summary Dashboard--
SELECT 
    o.order_id,
    u.name AS customer_name,
    COUNT(oi.item_id) AS total_items,
    SUM(oi.qty * oi.unit_price) AS order_value
FROM orders o
JOIN user u
    ON o.user_id = u.user_id
JOIN orderitems oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, u.name
ORDER BY order_value DESC;


-- Revenue Generated by Each Payment Method--
SELECT 
    p.method,
    COUNT(p.payment_id) AS total_transactions,
    SUM(p.amount) AS total_revenue,
    AVG(p.amount) AS average_transaction_value
FROM payments p
GROUP BY p.method
ORDER BY total_revenue DESC;

-- JOINs + Aggregate Functions + GROUP BY--

SELECT 
    u.user_id,
    u.name,
    u.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total) AS total_amount_spent
FROM user u
LEFT JOIN orders o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.name, u.email
ORDER BY total_amount_spent DESC;

-- using  like operator--
SELECT *
FROM user
WHERE name LIKE 'A%';

SELECT *
FROM user
WHERE name LIKE '%h';
SELECT *
FROM user
WHERE name LIKE '%in%';
SELECT *
FROM user
WHERE email LIKE '%@gmail.com';
SELECT *
FROM categories
WHERE name LIKE 'Ele%';

SELECT *
FROM categories
WHERE name LIKE '%Book%';

SELECT *
FROM shipments
WHERE tracking_number LIKE 'TRK%';

SELECT *
FROM user
WHERE name LIKE '______';

SELECT *
FROM user
WHERE phonenumber LIKE '9%';
SELECT *
FROM shipments
WHERE carrier LIKE '%Express%';

-- joins
SELECT DISTINCT u.user_id, u.name, u.email
FROM user u
JOIN orders o ON u.user_id = o.user_id;

SELECT DISTINCT u.user_id, u.name, u.email
FROM user u
JOIN orders o ON u.user_id = u.user_id;

SELECT u.name, COUNT(o.order_id) AS total_orders
FROM user u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_orders DESC;

SELECT product_id, name, category
FROM product
WHERE stock_qty = 0;

SELECT order_id,
       SUM(qty) AS total_quantity
FROM orderitems
GROUP BY order_id;


SHOW TABLES;

SELECT * from user
WHERE user_id=(select user_id
from user
where name='abinesh');

SELECT order_id
from orders
WHERE total =89;

SELECT user.user_id,user.name,user.phonenumber,product.product_id
FROM user
inner join product
ON user.user_id=product.product_id;

select*
from  coupons
where coupon_id is null;
SELECT *
from categories
WHERE category_id is not null;


SELECT DISTINCT
 user.user_id,
       user.name,
       user.email,
       wishlist.wishlist_id
FROM user
RIGHT JOIN wishlist
ON user.user_id = wishlist.user_id;

SELECT orderitems.order_id,
       orderitems.product_id,
       payment.payment_id,
       payment.order_id
FROM orderitems
LEFT JOIN payment
ON orderitems.order_id = payment.order_id;
-- Dump completed on 2026-07-07 14:17:21
