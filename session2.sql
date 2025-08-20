-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    country VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

-- Create orders table with foreign key
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name, email, country, city, signup_date) VALUES
(1, 'Alice Johnson', 'alice@gmail.com', 'USA', 'New York', '2022-01-10'),
(2, 'Bob Smith', 'bob@yahoo.com', 'UK', 'London', '2022-03-15'),
(3, 'Charlie Brown', 'charlie@gmail.com', 'USA', 'Los Angeles', '2022-02-20'),
(4, 'Diana Prince', 'diana@outlook.com', 'Canada', 'Toronto', '2022-04-05'),
(5, 'Eve Wilson', 'eve@gmail.com', 'UK', 'Manchester', '2022-01-30'),
(6, 'Frank Miller', 'frank@gmail.com', 'USA', 'Chicago', '2022-05-12'),
(7, 'Grace Lee', 'grace@outlook.com', 'Canada', 'Vancouver', '2022-06-18'),
(8, 'Hank Clark', 'hank@yahoo.com', 'USA', 'Houston', '2022-07-01');

INSERT INTO orders (order_id, customer_id, amount, order_date, status) VALUES
(101, 1, 150.00, '2023-01-05', 'completed'),
(102, 1, 200.50, '2023-02-10', 'completed'),
(103, 2, 99.99, '2023-01-15', 'completed'),
(104, 3, 300.00, '2023-01-20', 'pending'),
(105, 2, 125.75, '2023-03-01', 'completed'),
(106, 4, 450.25, '2023-02-28', 'completed'),
(107, 5, 75.00, '2023-01-12', 'completed'),
(108, 1, 180.00, '2023-03-05', 'completed'),
(109, 6, 220.00, '2023-02-14', 'completed'),
(110, 3, 100.00, '2023-03-10', 'canceled'),
(111, 7, 320.50, '2023-01-25', 'completed'),
(112, 8, 90.00, '2023-03-02', 'completed'),
(113, 5, 130.25, '2023-02-18', 'completed'),
(114, 4, 200.00, '2023-03-08', 'completed');

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT COUNT(DISTINCT country) 'number_of_countries'
FROM customers;

SELECT COUNT(*) 'number_of_customers_A_B'
FROM customers
WHERE Name LIKE 'A%' OR Name LIKE 'B%';

SELECT COUNT(*) 'number_of_customers_AN'
FROM customers
WHERE Name LIKE '%an%' OR Name LIKE '%An%';

SELECT SUM(amount) 'total_revenue', AVG(amount) 'average_price'
FROM orders;

SELECT country, COUNT(*) 'number_of_sales', SUM(amount) 'total_revenue'
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY country;

SELECT customers.name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
WHERE amount > (SELECT AVG(amount) 'average_price'
                FROM orders);

/*markdown
# Procedures
*/

/*markdown
Cannot be used in SELECT, cannot be altered since it is compiled.
*/

DROP PROCEDURE testProcedure;

CREATE PROCEDURE testProcedure(IN countryName VARCHAR(20), OUT samak INT)
BEGIN
    SELECT COUNT(*) INTO samak
    FROM customers
    WHERE country = countryName;
END;

CALL testProcedure('USA', @var);

SELECT @var;

DROP PROCEDURE totalSales();

CREATE PROCEDURE totalSales(IN givenDate DATE, OUT totalResult INT)
BEGIN
    SELECT SUM(amount) INTO totalResult
    FROM orders
    WHERE order_date = givenDate;
END;

CALL totalSales('2023-03-10', @myVar);
SELECT @myVar 'result';

/*markdown
# Functions
*/

/*markdown
Can be used in SELECT, can be altered.
*/

DROP FUNCTION sayHello;

-- if a value is sent, returns a value
-- if a col is sent, the parameter acts a single row and iterates over all rows like df.apply
CREATE FUNCTION sayHello(name VARCHAR(20))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN

RETURN CONCAT('Hello ', name);

END;

SELECT sayHello('Ali') 'result';

SELECT sayHello(name) 'result'
FROM customers;

-- THEN must be present after IF
-- must END IF at the end of the IF statement
-- do not forget the semicolons
CREATE FUNCTION determineScore(amount FLOAT)
RETURNS VARCHAR(4)
DETERMINISTIC
BEGIN

IF amount > 350 THEN 
    RETURN 'GOOD';
ELSE
    RETURN 'BAD';
END IF;

END;

SELECT determineScore(amount) 'modifier'
FROM orders;

/*markdown
# CTE
*/

WITH averageSpent AS (
    SELECT *
    FROM orders
    WHERE amount > 200
)
SELECT * 
FROM averageSpent;