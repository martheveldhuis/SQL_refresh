-- Find products that are more expensive than Lettuce (id = 3).

USE sql_inventory;

SELECT product_id, name, unit_price
FROM products
WHERE unit_price > (
	SELECT unit_price 
    FROM products 
    WHERE product_id = 3
);

-- Find all employees who earn more than average.

USE sql_hr;

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

-- Find all products that have never been ordered.

USE sql_store;

SELECT * 
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items
);

-- Find clients without invoices.

USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
    FROM invoices
);

SELECT *
FROM clients c
LEFT JOIN invoices i USING (client_id)
WHERE invoice_id IS NULL;

-- Find customers who have ordered Lettuce (id = 3).

-- USE sql_store;

-- Using JOINS.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;

-- Using subqueries.
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id
    FROM order_items oi
    JOIN orders o USING (order_id)
	WHERE product_id = 3
);

-- Select invoices larger than all invoices of client 3

USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
);

-- Select clients with at least two invoices.

SELECT * 
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

-- Select employees whose salary is above average.

USE sql_hr;

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);

-- Select invoices that are larger than the client's average invoice amount.

USE sql_invoicing;

SELECT * 
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);

-- Select clients that have an invoice

SELECT * 
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
)

-- Find the products that have never been ordered

USE sql_store;

SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
);

-- Subquery in SELECT clause

USE sql_invoicing;

SELECT 
	c.client_id,
    c.name,
	(SELECT SUM(invoice_total) FROM invoices 
		WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total) FROM invoices) AS average,
	(SELECT total_sales) - (SELECT average)	AS difference
FROM clients c;


-- Subquery in FROM clause

SELECT * 
FROM (
	SELECT 
		c.client_id,
		c.name,
		(SELECT SUM(invoice_total) FROM invoices 
			WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total) FROM invoices) AS average,
		(SELECT total_sales) - (SELECT average)	AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL;