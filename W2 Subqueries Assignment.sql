-- 1. Write a query to retrieve the order id, their quantity, their shipping address, and their shipping city. 
-- Make sure to include only those whose shipping country contains a ‘y’ and their quantity is greater than or equal 
-- to the average quantity.

SELECT
	DISTINCT(od.orderid),
	od.quantity,
	o.shipaddress,
	o.shipcity
FROM order_details od
JOIN orders o USING (orderid)
WHERE quantity > (select avg(quantity)from order_details) -- subquery
AND shipcountry LIKE '%y%';

select avg(quantity) -- subquery
from order_details

-- 2. Write a query to retrieve the information on orders whose employee’s territory id is 40222.
SELECT * 
FROM orders o
JOIN employeeterritories USING (employeeid)
WHERE territoryid = (SELECT -- SUBQUERY
					 	territoryid
					FROM employeeterritories
					WHERE territoryid = '40222'
					)

SELECT territoryid --subquery
FROM employeeterritories
WHERE territoryid = '40222'

-- 3. Write a query to retrieve the customer’s company name and the last name of the employee who processed their order for each order.
-- customer’s company name -> Customers 
-- last name of the employee -> Employees
-- DISTINCT orderid -> orders

SELECT 
	DISTINCT(orderid),
	
	(	SELECT companyname -- Sub 1
		FROM customers c
		WHERE c.customerid = o.customerid),
		
	(	SELECT lastname -- Sub 2
		FROM employees e
		WHERE e.employeeid = o.employeeid)
FROM orders o;

SELECT companyname -- Sub 1
FROM customers c
WHERE c.customerid = o.customerid


SELECT lastname -- Sub 2
FROM employees e
WHERE e.employeeid = o.employeeid
-- 4. Write a query to retrieve the product name and supplier name for each product.
-- DISTINCT Product name -> products
-- supplier name  -> suppliers

SELECT
	DISTINCT(productname),
	(
		SELECT companyname -- Subquery 1
		FROM suppliers s
		WHERE s.supplierid = p.supplierid
	 )
FROM products p;
	
SELECT companyname -- subquery 1
FROM suppliers s
WHERE s.supplierid = p.supplierid

-- 5. Write a query to retrieve the customer’s company name and the last name of the employee who processed their order. 
-- Include the order date and order ID.
-- customer’s company name -> Customers 
-- last name of the employee -> Employees
-- DISTINCT orderid -> orders

SELECT 
	DISTINCT(orderid),
	orderdate,
	
	(	SELECT companyname -- Sub 1
		FROM customers c
		WHERE c.customerid = o.customerid),
		
	(	SELECT lastname -- Sub 2
		FROM employees e
		WHERE e.employeeid = o.employeeid)
FROM orders o;


SELECT companyname -- Sub 1
FROM customers c
WHERE c.customerid = o.customerid

SELECT lastname -- Sub 2
FROM employees e
WHERE e.employeeid = o.employeeid

SELECT 
	(	SELECT companyname -- Sub 1
		FROM customers c
		WHERE c.customerid = o.customerid),
		
	(	SELECT lastname -- Sub 2
		FROM employees e
		WHERE e.employeeid = o.employeeid)
FROM orders o;


-- 6. List all products whose unit price is greater than the average unit price of all products in the same category.
-- products whose 
-- unit price is > than the average unit price of all products in the same category.

SELECT 
	productname, unitprice, ct.avg_unitprice
FROM products 
JOIN (SELECT -- SUBQUERY
		avg(unitprice) AS avg_unitprice, categoryid
	FROM products
	GROUP BY categoryid) AS ct
USING (categoryid)
WHERE unitprice > ct.avg_unitprice

SELECT --SUBQUERY 
	categoryid,
	avg(unitprice) AS Avg_unitprice
FROM products
GROUP BY categoryid

--
