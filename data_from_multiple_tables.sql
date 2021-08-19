SELECT oi.product_id, name, quantity, oi.unit_price
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id;

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN employees m 
	ON e.reports_to = m.employee_id;
    
SELECT p.date, 
	   p.payment_id, 
       p.amount, 
       c.name, 
       pm.name
FROM payments p
JOIN clients c
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;


USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id;

SELECT 
    o.order_id, 
	o.order_date, 
    c.first_name AS customer, 
    sh.name AS shipper, 
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;
    
SELECT 
    o.order_id, 
	o.order_date, 
    c.first_name AS customer, 
    sh.name AS shipper, 
    os.name AS status
FROM orders o
JOIN customers c
	USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id)
JOIN order_statuses os
	ON o.status = os.order_status_id;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id);


USE sql_invoicing;

SELECT p.date,
	   c.name AS client, 
       p.amount,
       pm.name AS 'payment method'
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;


USE sql_store;

SELECT customer_id,
	   first_name,
       points,
       'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id,
	   first_name,
       points,
       'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id,
	   first_name,
       points,
       'Gold' AS type
FROM customers
WHERE points >= 3000
ORDER BY points