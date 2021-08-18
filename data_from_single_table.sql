SELECT 
	first_name, last_name, 
 points, (points + 10) * 100 AS 'discount factor'
FROM customers;

SELECT * 
FROM order_items
WHERE order_id = 6 AND (quantity * unit_price) > 30;

SELECT * 
FROM products
WHERE quantity_in_stock IN (49, 38, 72);

SELECT * 
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
	  phone NOT LIKE '%9';

SELECT *
FROM customers
WHERE first_name REGEXP 'elka|ambur';

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';

SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';

SELECT *
FROM orders
WHERE shipped_date IS NULL;
      
SELECT *,  quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;


