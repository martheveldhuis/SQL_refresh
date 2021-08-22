-- Find products that are more expensive than Lettuce (id = 3)

-- USE sql_inventory;

-- SELECT product_id, name, unit_price
-- FROM products
-- WHERE unit_price > (
-- 	SELECT unit_price 
--     FROM products 
--     WHERE product_id = 3
-- );

-- Find all employees who earn more than average

-- USE sql_hr;

-- SELECT first_name, last_name, salary
-- FROM employees
-- WHERE salary > (
-- 	SELECT AVG(salary)
-- 	FROM employees
-- );


