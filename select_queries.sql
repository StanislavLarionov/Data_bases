-- 1. Які клієнти є в базі даних?
SELECT * FROM customers;

-- 2. Які клієнти зробили найбільшу кількість звернень до служби підтримки?
SELECT customers.name, COUNT(support_tickets.id) AS ticket_amount
FROM customers
JOIN support_tickets ON customers.id = support_tickets.customer_id
GROUP BY customers.name
ORDER BY ticket_amount DESC;

-- 3. Яка середня кількість звернень на одного клієнта?
SELECT AVG(ticket_amount) AS average_tickets_per_customer
FROM(
	SELECT COUNT(support_tickets.id) AS ticket_amount
	FROM customers
	LEFT JOIN support_tickets ON customers.id = support_tickets.customer_id
	GROUP BY customers.id
);

-- 4. Яка максимальна кількість запитів на певного клієнта?
SELECT COUNT(s.id) max_order_amount, name, last_name, customer_id
FROM support_tickets as s
JOIN customers as c ON c.id = customer_id
GROUP BY name, last_name, customer_id
HAVING COUNT(s.id) = (SELECT MAX(count)
FROM(
	SELECT COUNT(s.id)
	FROM support_tickets as s
	GROUP BY customer_id
));

-- 5. Скільки клієнтів ще не вирішили свої питання?
SELECT COUNT(DISTINCT customer_id) AS unresolved_customer_count
FROM support_tickets
WHERE status != 'resolved';

-- 6. Які запити закриті з певними типами статусів (наприклад, вирішено)?
SELECT support_tickets.id, name, last_name, title, details, status
FROM support_tickets
JOIN customers ON customer_id = customers.id
WHERE status = 'resolved';

-- 7. Які клієнти потребують термінового вирішення питання?
SELECT customers.id, name, last_name
FROM customers
JOIN support_tickets ON customers.id = customer_id
WHERE priority = 'urgent' AND status != 'resolved'

-- 8. Які послуги найбільше замовляють клієнти?
SELECT products.name product_name, COUNT(Orders.id) AS number_of_orders
FROM products
JOIN orders ON products.id = orders.product_id
GROUP BY products.name
ORDER BY number_of_orders DESC;

-- 9. Скільки клієнтів подали запити за певний час?
SELECT COUNT(DISTINCT customer_id) AS number_of_customers
FROM support_tickets
WHERE submit_date BETWEEN '2024-03-01' AND '2024-03-31';

-- 10. Яка середня часова затримка між поданням запиту та його обробкою?
SELECT AVG(resolved_date - submit_date) AS average_resolution_time
FROM support_tickets
WHERE resolved_date IS NOT NULL;