USE sql_invoicing;

CREATE OR REPLACE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(i.invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

SELECT *
FROM sales_by_client
WHERE total_sales > 500;

CREATE OR REPLACE VIEW client_balance AS
SELECT
	c.client_id,
    c.name,
	SUM(i.invoice_total - i.payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

DROP VIEW sales_by_client;

-- Updatable views

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_date,
    invoice_total - payment_total AS balance,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0;

DELETE FROM invoices_with_balance
WHERE invoice_id = 1;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2;