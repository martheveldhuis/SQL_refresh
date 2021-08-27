-- Get orders from the current year.

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = EXTRACT(YEAR FROM NOW());

-- Get some information from customers, add Unkown if phone is null.
SELECT 
	CONCAT(first_name, ' ', last_name) AS customer,
    COALESCE(phone, 'Unknown') AS phone
FROM customers;

-- IF function - Get some product info, adding a frequency column (once / many times)

SELECT 
	DISTINCT oi.product_id,
    p.name,
	(SELECT COUNT(*) FROM order_items 
		WHERE product_id = oi.product_id) AS orders,
    IF(
		(SELECT orders) = 1,
		'Once',
        'Many times'
	) AS frequency
FROM order_items oi
JOIN products p USING (product_id);

-- Better version

SELECT 
	p.product_id,
    p.name,
    COUNT(*) AS orders,
    IF(
		COUNT(*) = 1,
		'Once',
        'Many times'
	) AS frequency
FROM products p
JOIN order_items oi USING (product_id)
GROUP BY p.product_id, p.name;

-- Case function - classify customers

SELECT
	CONCAT(first_name, ' ', last_name) AS customer,
    points,
    CASE
		WHEN points > 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Silver'
        ELSE 'Bronze'
	END AS category
FROM customers
ORDER BY points;