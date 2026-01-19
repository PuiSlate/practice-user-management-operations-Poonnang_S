START TRANSACTION;

DROP TABLE IF EXISTS customers, orders;

CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1,'2023-01-01', 100.00),
(2, 1,'2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

SELECT * FROM customers;
SELECT * FROM orders;

-- task1 join queries
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders INNER JOIN customers ON orders.customer_id = customers.id;

-- use LEFT JOIN to see the order date and total amount spent by each customers sorted by their last name
SELECT customers.last_name, orders.order_date, orders.total_amount
FROM orders LEFT JOIN customers ON orders.id = customers.id;

-- task2 GROUP BY queries

-- use GROUP BY to find the total amount spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- use GROUP BY to find the times of purchases by each customer by their last name
SELECT customers.last_name, COUNT(*) AS times_of_purchase
FROM customers
GROUP BY last_name;

-- task3 Apply WHERE and HAVING clauses

-- use WHERE clause to filter the results to only include orders that are greater than to $150:
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 150
GROUP BY customer_id;

-- add a HAVING clause to filter the results to only include customers who have spent more than $150 total:
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 150;

-- task4 using SubQueries
-- return all orders where the total_amount is greater than or equal to the average total_amount of all orders

SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 

-- return all orders where the customer_id is in the list of id values of customers with the last name 'Doe'.
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Doe');

COMMIT;