SELECT 
	MAX(payment_date) AS highest, 
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total * 1.1) AS total,
    COUNT(DISTINCT client_id) AS total_records
FROM invoices
WHERE invoice_date > '2019-07-01';

SELECT
	'First half of 2019' AS date_range, 
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT
	'Second half of 2019' AS date_range, 
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
	'Total' AS date_range, 
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';


SELECT
	state,
    city,
    SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id)
GROUP BY state, city;

SELECT 
	p.date,
    pm.name AS payment_method,
    SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm 
	ON p.payment_method = pm.payment_method_id
GROUP BY p.date, payment_method
ORDER BY p.date;

USE sql_store;

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE c.state = 'VA'
GROUP BY 
	c.customer_id,
    c.first_name, 
    c.last_name
HAVING total_sales > 100;


USE sql_invoicing;

SELECT 
    pm.name AS payment_method,
    SUM(p.amount) AS total
FROM payments p
JOIN payment_methods pm 
	ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;



