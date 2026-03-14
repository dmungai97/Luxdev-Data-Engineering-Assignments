-- =====================================================
-- PART 2 : SUBQUERY QUESTIONS
-- =====================================================

-- Question 51
SELECT c.customer_id, c.first_name, c.last_name,
SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT SUM(total_amount) AS customer_total
        FROM assignment.sales
        GROUP BY customer_id
    ) AS avg_spending
);

-- Question 52
SELECT *
FROM assignment.products
WHERE price >
(
    SELECT AVG(price)
    FROM assignment.products
);

-- Question 53
SELECT *
FROM assignment.customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM assignment.sales
);

-- Question 54
SELECT *
FROM assignment.products
WHERE product_id NOT IN
(
    SELECT product_id
    FROM assignment.sales
);

-- Question 55
SELECT c.customer_id, c.first_name, c.last_name, s.total_amount
FROM assignment.sales s
JOIN assignment.customers c ON s.customer_id = c.customer_id
WHERE s.total_amount =
(
    SELECT MAX(total_amount)
    FROM assignment.sales
);

-- Question 56
SELECT p.product_name,
SUM(s.total_amount) AS total_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING SUM(s.total_amount) >
(
    SELECT AVG(product_sales)
    FROM
    (
        SELECT SUM(total_amount) AS product_sales
        FROM assignment.sales
        GROUP BY product_id
    ) AS avg_sales
);

-- Question 57
SELECT *
FROM assignment.customers
WHERE registration_date <
(
    SELECT AVG(registration_date)
    FROM assignment.customers
);

-- Question 58
SELECT *
FROM assignment.products p
WHERE price >
(
    SELECT AVG(price)
    FROM assignment.products
    WHERE category = p.category
);

-- Question 59
SELECT customer_id,
SUM(total_amount) AS total_spent
FROM assignment.sales
GROUP BY customer_id
HAVING SUM(total_amount) >
(
    SELECT SUM(total_amount)
    FROM assignment.sales
    WHERE customer_id = 10
);

-- Question 60
SELECT p.product_name,
SUM(s.quantity_sold) AS total_quantity
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) >
(
    SELECT AVG(quantity_sold)
    FROM assignment.sales
);

-- =====================================================
-- COMMON TABLE EXPRESSIONS (CTEs)
-- =====================================================

-- Question 61
WITH customer_spending AS (
SELECT customer_id, SUM(total_amount) AS total_spent
FROM assignment.sales
GROUP BY customer_id
)
SELECT *
FROM customer_spending
ORDER BY total_spent DESC
LIMIT 5;

-- Question 62
WITH product_sales AS (
SELECT product_id, SUM(quantity_sold) AS total_sold
FROM assignment.sales
GROUP BY product_id
)
SELECT *
FROM product_sales
ORDER BY total_sold DESC
LIMIT 3;

-- Question 63
WITH category_sales AS (
SELECT p.category, SUM(s.total_amount) AS revenue
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.category
)
SELECT *
FROM category_sales
ORDER BY revenue DESC
LIMIT 1;

-- Question 64
WITH purchase_count AS (
SELECT customer_id, COUNT(*) AS purchases
FROM assignment.sales
GROUP BY customer_id
)
SELECT *
FROM purchase_count
WHERE purchases > 2;

-- Question 65
WITH product_quantities AS (
SELECT product_id, SUM(quantity_sold) AS total_qty
FROM assignment.sales
GROUP BY product_id
)
SELECT *
FROM product_quantities
WHERE total_qty >
(
SELECT AVG(total_qty)
FROM product_quantities
);

-- Question 66
WITH spending AS (
SELECT customer_id, SUM(total_amount) AS total_spent
FROM assignment.sales
GROUP BY customer_id
)
SELECT *
FROM spending
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM spending
);

-- Question 67
WITH revenue_per_product AS (
SELECT product_id, SUM(total_amount) AS revenue
FROM assignment.sales
GROUP BY product_id
)
SELECT *
FROM revenue_per_product
ORDER BY revenue DESC;

-- Question 68
WITH monthly_sales AS (
SELECT YEAR(sale_date) AS year,
MONTH(sale_date) AS month,
SUM(total_amount) AS revenue
FROM assignment.sales
GROUP BY year, month
)
SELECT *
FROM monthly_sales
ORDER BY revenue DESC
LIMIT 1;

-- Question 69
WITH product_customers AS (
SELECT product_id, COUNT(DISTINCT customer_id) AS customer_count
FROM assignment.sales
GROUP BY product_id
)
SELECT *
FROM product_customers
WHERE customer_count > 3;

-- Question 70
WITH quantity_sales AS (
SELECT product_id, SUM(quantity_sold) AS total_qty
FROM assignment.sales
GROUP BY product_id
)
SELECT *
FROM quantity_sales
WHERE total_qty <
(
SELECT AVG(total_qty)
FROM quantity_sales
);

-- =====================================================
-- WINDOW FUNCTIONS
-- =====================================================

-- Question 71
SELECT customer_id,
SUM(total_amount) AS total_spent,
RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM assignment.sales
GROUP BY customer_id;

-- Question 72
SELECT product_id,
SUM(quantity_sold) AS total_sold,
RANK() OVER (ORDER BY SUM(quantity_sold) DESC) AS product_rank
FROM assignment.sales
GROUP BY product_id;

-- Question 73
SELECT *
FROM (
SELECT customer_id,
SUM(total_amount) AS total_spent,
RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_pos
FROM assignment.sales
GROUP BY customer_id
) ranked
WHERE rank_pos = 3;

-- Question 74
SELECT *
FROM (
SELECT product_name, price,
RANK() OVER (ORDER BY price DESC) AS rank_pos
FROM assignment.products
) ranked
WHERE rank_pos = 2;

-- Question 75
SELECT product_name, category, price,
RANK() OVER (PARTITION BY category ORDER BY price DESC) AS category_rank
FROM assignment.products;

-- Question 76
SELECT customer_id,
COUNT(*) AS purchase_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS purchase_rank
FROM assignment.sales
GROUP BY customer_id;

-- Question 77
SELECT sale_id, sale_date, total_amount,
SUM(total_amount) OVER (ORDER BY sale_date) AS running_total
FROM assignment.sales;

-- Question 78
SELECT sale_id, sale_date, total_amount,
LAG(total_amount) OVER (ORDER BY sale_date) AS previous_sale
FROM assignment.sales;

-- Question 79
SELECT sale_id, sale_date, total_amount,
LEAD(total_amount) OVER (ORDER BY sale_date) AS next_sale
FROM assignment.sales;

-- Question 80
SELECT customer_id,
SUM(total_amount) AS total_spent,
NTILE(4) OVER (ORDER BY SUM(total_amount) DESC) AS spending_group
FROM assignment.sales
GROUP BY customer_id;

-- =====================================================
-- ADVANCED ANALYTICAL QUESTIONS
-- =====================================================

-- Question 81
SELECT c.customer_id
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT p.category) > 1;

-- Question 82
SELECT c.customer_id
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE DATEDIFF(s.sale_date, c.registration_date) <= 7;

-- Question 83
SELECT *
FROM assignment.inventory
WHERE stock_quantity <
(
SELECT AVG(stock_quantity)
FROM assignment.inventory
);

-- Question 84
SELECT customer_id, product_id, COUNT(*) AS purchases
FROM assignment.sales
GROUP BY customer_id, product_id
HAVING COUNT(*) > 1;

-- Question 85
SELECT p.category,
SUM(s.total_amount) AS revenue
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Question 86
SELECT *
FROM (
SELECT product_id,
SUM(quantity_sold) AS total_sold,
RANK() OVER (ORDER BY SUM(quantity_sold) DESC) AS rnk
FROM assignment.sales
GROUP BY product_id
) ranked
WHERE rnk <= 3;

-- Question 87
SELECT DISTINCT c.customer_id
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price =
(
SELECT MAX(price)
FROM assignment.products
);

-- Question 88
SELECT product_id,
COUNT(DISTINCT customer_id) AS unique_customers
FROM assignment.sales
GROUP BY product_id
ORDER BY unique_customers DESC;

-- Question 89
SELECT DISTINCT customer_id
FROM assignment.sales
WHERE total_amount >
(
SELECT AVG(total_amount)
FROM assignment.sales
);

-- Question 90
SELECT customer_id,
SUM(quantity_sold) AS total_qty
FROM assignment.sales
GROUP BY customer_id
HAVING SUM(quantity_sold) >
(
SELECT AVG(total_qty)
FROM (
SELECT SUM(quantity_sold) AS total_qty
FROM assignment.sales
GROUP BY customer_id
) avg_table
);

-- =====================================================
-- ADVANCED WINDOW + ANALYTICAL
-- =====================================================

-- Question 91
SELECT *
FROM (
SELECT customer_id,
SUM(total_amount) AS total_spent,
PERCENT_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS percentile
FROM assignment.sales
GROUP BY customer_id
) ranked
WHERE percentile <= 0.10;

-- Question 92
SELECT product_id,
SUM(total_amount) AS revenue,
SUM(SUM(total_amount)) OVER () AS total_revenue
FROM assignment.sales
GROUP BY product_id;

-- Question 93
SELECT DISTINCT s1.customer_id
FROM assignment.sales s1
JOIN assignment.sales s2
ON s1.customer_id = s2.customer_id
AND TIMESTAMPDIFF(MONTH, s1.sale_date, s2.sale_date) = 1;

-- Question 94
SELECT p.product_name,
i.stock_quantity - COALESCE(SUM(s.quantity_sold),0) AS stock_difference
FROM assignment.products p
JOIN assignment.inventory i ON p.product_id = i.product_id
LEFT JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name, i.stock_quantity
ORDER BY stock_difference DESC;

-- Question 95
SELECT customer_id, total_spent
FROM (
SELECT c.customer_id,
c.membership_status,
SUM(s.total_amount) AS total_spent,
AVG(SUM(s.total_amount)) OVER (PARTITION BY c.membership_status) AS tier_avg
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.membership_status
) ranked
WHERE total_spent > tier_avg;

-- Question 96
SELECT *
FROM (
SELECT p.category,
p.product_id,
SUM(s.total_amount) AS sales,
AVG(SUM(s.total_amount)) OVER (PARTITION BY p.category) AS avg_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.category
) ranked
WHERE sales > avg_sales;

-- Question 97
SELECT customer_id, sale_id, total_amount
FROM assignment.sales
ORDER BY total_amount DESC
LIMIT 1;

-- Question 98
SELECT *
FROM (
SELECT p.category, p.product_id,
SUM(s.quantity_sold) AS total_sold,
RANK() OVER (PARTITION BY p.category ORDER BY SUM(s.quantity_sold) DESC) AS rnk
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.category
) ranked
WHERE rnk <= 3;

-- Question 99
SELECT customer_id,
SUM(total_amount) AS total_spent
FROM assignment.sales
GROUP BY customer_id
HAVING SUM(total_amount) =
(
SELECT MAX(total_spent)
FROM (
SELECT SUM(total_amount) AS total_spent
FROM assignment.sales
GROUP BY customer_id
) max_table
);

-- Question 100
SELECT product_id
FROM assignment.sales
GROUP BY product_id
HAVING COUNT(DISTINCT YEAR(sale_date)) =
(
SELECT COUNT(DISTINCT YEAR(sale_date))
FROM assignment.sales
);
