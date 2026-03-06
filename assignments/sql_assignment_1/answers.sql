-- Question 1
SELECT *
FROM assignment.customers;

-- Question 2
SELECT COUNT(*) AS total_products
FROM assignment.products;

-- Question 3
SELECT product_name, price
FROM assignment.products
WHERE price > 500;

-- Question 4
SELECT AVG(price) AS average_price
FROM assignment.products;

-- Question 5
SELECT SUM(total_amount) AS total_sales
FROM assignment.sales;

-- Question 6
SELECT DISTINCT membership_status
FROM assignment.customers;

-- Question 7
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM assignment.customers;

-- Question 8
SELECT *
FROM assignment.products
WHERE category = 'Electronics';

-- Question 9
SELECT MAX(price) AS highest_price
FROM assignment.products;

-- Question 10
SELECT product_id, COUNT(*) AS sales_count
FROM assignment.sales
GROUP BY product_id;

-- Question 11
SELECT product_id, SUM(quantity_sold) AS total_quantity_sold
FROM assignment.sales
GROUP BY product_id;

-- Question 12
SELECT MIN(price) AS lowest_price
FROM assignment.products;

-- Question 13
SELECT DISTINCT c.*
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price > 1000;

-- Question 14
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Question 15
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Question 16
SELECT c.first_name, c.last_name, p.product_name, s.quantity_sold
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id;

-- Question 17
SELECT c1.customer_id AS customer1, c2.customer_id AS customer2, c1.membership_status
FROM assignment.customers c1
JOIN assignment.customers c2
ON c1.membership_status = c2.membership_status
AND c1.customer_id < c2.customer_id;

-- Question 18
SELECT p.product_name, COUNT(s.sale_id) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Question 19
SELECT *
FROM assignment.products
WHERE stock_quantity < 10;

-- Question 20
SELECT p.product_name, SUM(s.quantity_sold) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) > 5;

-- Question 21
SELECT DISTINCT c.*
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.category IN ('Electronics', 'Appliances');

-- Question 22
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Question 23
SELECT DISTINCT c.*
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE YEAR(s.sale_date) = 2023;

-- Question 24
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_sales
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE YEAR(s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sales DESC
LIMIT 1;

-- Question 25
SELECT p.product_name, p.price
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
ORDER BY p.price DESC
LIMIT 1;

-- Question 26
SELECT COUNT(DISTINCT c.customer_id) AS customers_above_500
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price > 500;

-- Question 27
SELECT COUNT(*) AS total_sales_gold_customers
FROM assignment.sales s
JOIN assignment.customers c ON s.customer_id = c.customer_id
WHERE c.membership_status = 'Gold';

-- Question 28
SELECT p.product_name, i.stock_quantity
FROM assignment.products p
JOIN assignment.inventory i ON p.product_id = i.product_id
WHERE i.stock_quantity < 10;

-- Question 29
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.quantity_sold) AS total_products_bought
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.quantity_sold) > 5;

-- Question 30
SELECT product_id, AVG(quantity_sold) AS average_quantity_sold
FROM assignment.sales
GROUP BY product_id;

-- Question 31
SELECT COUNT(*) AS december_sales
FROM assignment.sales
WHERE YEAR(sale_date) = 2023
AND MONTH(sale_date) = 12;

-- Question 32
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent_2023
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE YEAR(s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent_2023 DESC;

-- Question 33
SELECT p.product_name, i.stock_quantity
FROM assignment.products p
JOIN assignment.inventory i ON p.product_id = i.product_id
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE i.stock_quantity < 5;

-- Question 34
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- Question 35
SELECT c.customer_id, c.first_name, c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE DATEDIFF(s.sale_date, c.registration_date) <= 7;

-- Question 36
SELECT p.product_name, s.total_amount
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price BETWEEN 100 AND 500;

-- Question 37
SELECT customer_id, COUNT(*) AS purchase_count
FROM assignment.sales
GROUP BY customer_id
ORDER BY purchase_count DESC
LIMIT 1;

-- Question 38
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.quantity_sold) AS total_quantity
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Question 39
SELECT product_name, stock_quantity
FROM assignment.products
WHERE stock_quantity = (SELECT MAX(stock_quantity) FROM assignment.products)
OR stock_quantity = (SELECT MIN(stock_quantity) FROM assignment.products);

-- Question 40
SELECT p.product_name, SUM(s.quantity_sold) AS total_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.product_name LIKE '%Phone%'
GROUP BY p.product_name;

-- Question 41
SELECT c.first_name, c.last_name, p.product_name, s.total_amount
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE c.membership_status = 'Gold';

-- Question 42
SELECT p.category, SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.category;

-- Question 43
SELECT p.product_name,
YEAR(s.sale_date) AS year,
MONTH(s.sale_date) AS month,
SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name, YEAR(s.sale_date), MONTH(s.sale_date);

-- Question 44
SELECT p.product_name, i.stock_quantity
FROM assignment.sales s
JOIN assignment.inventory i ON s.product_id = i.product_id
JOIN assignment.products p ON p.product_id = s.product_id
WHERE i.stock_quantity > 0;

-- Question 45
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- Question 46
SELECT COUNT(DISTINCT product_id) AS unique_products_sold_2023
FROM assignment.sales
WHERE YEAR(sale_date) = 2023;

-- Question 47
SELECT p.product_name
FROM assignment.products p
LEFT JOIN assignment.sales s
ON p.product_id = s.product_id
AND s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE s.product_id IS NULL;

-- Question 48
SELECT p.product_name, SUM(s.quantity_sold) AS total_quantity_sold
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.price BETWEEN 200 AND 800
GROUP BY p.product_name;

-- Question 49
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE YEAR(s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;

-- Question 50
SELECT p.product_name, SUM(s.quantity_sold) AS total_units_sold
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.price > 200
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) > 100;
