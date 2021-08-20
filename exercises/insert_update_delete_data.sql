INSERT INTO customers (
	first_name, 
    last_name, 
    birth_date,
    address,
    city,
    state)

VALUES(
    'John', 
    'Smith', 
    '1990-01-01', 
    'address',
    'city',
    'CA');

INSERT INTO products (
	name, 
    quantity_in_stock, 
    unit_price)

VALUES('product1', 100, 1.00),
	  ('product2', 200, 2.00),
      ('product3', 300, 3.00);


INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES(LAST_INSERT_ID(), 1, 1, 2.95),
	  (LAST_INSERT_ID(), 2, 1, 3.95);


CREATE TABLE invoices_archived AS
SELECT 
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.due_date,
    i.payment_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;



UPDATE invoices
SET
	payment_total = invoice_total * 0.5, 
	payment_date = due_date
WHERE client_id IN (3, 4);

USE sql_store;

UPDATE customers
SET
	points = points + 50
WHERE birth_date < '1990-01-01';

USE sql_store;

UPDATE orders
SET	comments = 'cool people'
WHERE customer_id IN 
			(SELECT customer_id
			 FROM customers
             WHERE points > 3000);



USE sql_invoicing;

DELETE FROM invoices
WHERE client_id = (
	SELECT client_id
	FROM clients
	WHERE name = 'Myworks');