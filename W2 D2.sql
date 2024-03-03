SELECT p.productid, p.productname, c.categoryid, c.description
FROM products p
JOIN categories c
ON p.categoryid = c.categoryid;

SELECT productid, p.categoryid, productname, categoryname, description 
FROM products p
JOIN categories c
ON p.categoryid = c.categoryid

SELECT c.contactname, o.orderid
FROM customers c
LEFT JOIN orders o
ON c.customerid = o.customerid

SELECT c.contactname, o.orderid
FROM customers c
JOIN orders o
ON c.customerid = o.customerid;

SELECT * FROM products;
SELECT * FROM suppliers;

SELECT * 
FROM products 
WHERE supplierid IS NULL

SELECT productname, unitprice,region
FROM products p
JOIN suppliers s
ON p.supplierid = s.supplierid
WHERE country <> 'USA'

SELECT productname, categoryname
FROM products p
JOIN categories c
ON p.categoryid = c.categoryid;

SELECT EXTRACT(Month FROM requireddate) AS requiredmonth
FROM orders
WHERE EXTRACT(Month FROM requireddate) >= 4 AND EXTRACT(Month FROM requireddate) <=6

SELECT DISTINCT(CONCAT(p.productid, o.customerid)), EXTRACT(Month FROM requireddate) AS requiredmonth
FROM products p
JOIN order_details od
ON p.productid = od.productid
JOIN orders o
ON od.orderid = o.orderid
WHERE EXTRACT(Month FROM requireddate) >= 4 AND EXTRACT(Month FROM requireddate) <=6

SELECT DISTINCT(o.customerid) AS customerid, od.productid 
FROM order_details od
JOIN orders o
ON od.orderid = o.orderid
WHERE o.requireddate BETWEEN '1998-04-01' AND '1998-06-30'

-- show each employee full name and their territorydescription
SELECT 
e.employeeid,
et.territoryid
FROM employees e
LEFT JOIN employeeterritories et 
ON e.employeeid = et.employeeid;

SELECT 
	e.firstname || ' ' || e.lastname AS fullname,
	t.territorydescription,
	r.regiondescription

FROM employees e
LEFT JOIN employeeterritories et USING (employeeid)
LEFT JOIN territories t USING (territoryid)
LEFT JOIN region r USING (regionid);

--subqueries
-- Make a table with product names, units in stock and average units in stock for all products
SELECT 
	AVG(unitsinstock) AS avg_stock
FROM products;

SELECT 
	productname, 
	unitsinstock,
	(SELECT 
		AVG(unitsinstock) AS avg_stock
	FROM products)
FROM products;

-- SELECT 
-- 	productname, 
-- 	unitsinstock,
-- 	AVG(unitsinstock) AS avg_stock
-- FROM products
-- GROUP BY 
-- 	productname,
-- 	unitsinstock;

--SUBQUERY in a WHERE statement
-- List information  on producrs that have never had a discount > 0.20
SELECT 
	DISTINCT productid
FROM order_details
WHERE discount > 0.2;

SELECT *
FROM products 
WHERE productid NOT IN (
	SELECT DISTINCT productid
	FROM order_details
	WHERE discount > 0.2)

-- show orderid, country and freight difference from overall average freight
SELECT 
	orderid, 
	shipcountry AS country,
	freight - (SELECT AVG(freight) FROM orders) AS freight_diff
FROM orders;

SELECT 
	AVG(freight)
FROM orders

-- Compare the AVG freight of orders to Germany with avg freight of orders to France
SELECT 
(
	(SELECT AVG(freight) FROM orders WHERE shipcountry = 'Germany') - 
	(SELECT AVG(freight) FROM orders WHERE shipcountry = 'France')
) AS avg_diff
;

SELECT AVG(freight) FROM orders WHERE shipcountry = 'Germany'
SELECT AVG(freight) FROM orders WHERE shipcountry = 'France'

-- show all product (names) with a supplier from Germany
SELECT
	supplierid
FROM suppliers
WHERE country = 'Germany';

SELECT supplierid
FROM suppliers
WHERE supplierid IN (
	SELECT
		supplierid
	FROM suppliers
	WHERE country = 'Germany'
	);
	
SELECT productname
FROM products
WHERE supplierid IN (
	SELECT
		supplierid
	FROM suppliers
	WHERE country = 'Germany'
	);

-- show orderid and country for orders wuth higher than average total value (including discount)
SELECT 
	sum(unitprice * quantity * (1-discount)) AS total
FROM order_details
GROUP BY orderid;

SELECT 	
	AVG(total) AS avg_total
FROM (SELECT 
	  	sum(unitprice * quantity * (1-discount)) AS total
	  FROM order_details
	  GROUP BY orderid) AS new_sub
	  
SELECT 
	orderid
FROM order_details
GROUP BY orderid
HAVING SUM(unitprice * quantity * (1-discount))> 
	(SELECT 	
		AVG(total) AS avg_total
	FROM (SELECT 
	  	sum(unitprice * quantity * (1-discount)) AS total
	  FROM order_details
	  GROUP BY orderid) AS new_sub)