/*
SELECT Subquery
writing a query to retrieve the product name and the total number of units in stock for each product in the products table. 
You should include a column that displays the number of units sold for that product.

Step 1: examine the data from products and order_details tables and identify what information should be retrieved:
1. productname, unitsinstock from products table
2. SUM of quantity from order_details table
*/

SELECT * FROM products; -- 1.
SELECT * FROM order_details; -- 2.

/* 
Step 2: write the query and make sure to include the SELECT subquery to get the total number of units in stock. 
To get this information, you will need to link the products table with the order_details table through productid
*/
SELECT 
	productname, 
	unitsinstock,
	(SELECT SUM(quantity)
	FROM order_details od
	WHERE p.productid = od.productid) AS unitssold
FROM products p
	
SELECT SUM(quantity) -- Nested Query
FROM order_details od, products p
WHERE p.productid = od.productid 

/* 
FROM Subquery
Write a query to retrieve the product name and the name of the supplier for each product in the products table. 
You should include a column that displays the number of products supplied by each supplier.
*/

/* 
Step 1: examine the data from products and suppliers tables and identify what information should be retrieved:

1. productname and the COUNT of the products supplied by each supplier from products table
2. companyname from suppliers table
*/
SELECT * FROM products; -- 1
SELECT * FROM suppliers; -- 2

/* 
tep 2: write the query and make sure to include the FROM subquery to get the number of products supplied by each supplier.
To get this information, you will need to link the products table with the suppliers table through supplierid.
*/
SELECT
	productname,
	companyname,
	sp.numproductssupplied	
FROM products p
	JOIN 
		(SELECT
			supplierid,
			COUNT(*) AS numproductssupplied
		FROM products p
		GROUP BY supplierid) AS sp
	ON p.supplierid = sp.supplierid
JOIN suppliers s
ON p.supplierid = s.supplierid;

SELECT -- subqueried
	supplierid, 
	COUNT(*) AS numproductssupplied
FROM products p
GROUP BY supplierid

/* 
WHERE Subquery
List all products that have been ordered more than 10 times.
*/

/* 
Step 1: examine the data from products and order_details tables and identify what information should be retrieved:

productname from products table
COUNT of orders from order_details table
*/

SELECT DISTINCT(productname)
FROM products
WHERE productid IN (
	SELECT 
		productid
	FROM order_details
	GROUP BY productid
	HAVING COUNT(*) > 10)

SELECT -- SUBQUERIES
	productid
FROM order_details
GROUP BY productid
HAVING COUNT(*) > 10

SELECT DISTINCT(productname) AS productname
FROM products p
WHERE productid IN (
    SELECT od.productid
    FROM order_details od, products p
    WHERE od.productid = p.productid
    GROUP BY od.productid
    HAVING COUNT(*) > 10
)