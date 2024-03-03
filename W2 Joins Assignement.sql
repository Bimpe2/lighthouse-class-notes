--
SELECT 
	DISTINCT(productname)
FROM products p
JOIN order_details od USING (productid)
WHERE discount > 0;

SELECT DISTINCT(productname) AS productname
FROM order_details od
JOIN products p
ON od.productid = p.productid
WHERE discount > 0;

-- 2. What are the last names of all employees who made sales before 1998?
SELECT DISTINCT(e.lastname) AS lastname
FROM employees e
JOIN orders o USING (employeeid)
WHERE o.orderdate < '1998-01-01';

-- 3. List all details on orders made by the Sales Representative employee.
SELECT o.*
FROM employees e
JOIN orders o USING (employeeid)
WHERE e.title = 'Sales Representative';

-- 4. List the territory and region description for each employee ID.
SELECT
	DISTINCT(et.employeeid),
	t.territorydescription AS territorydescr, 
	r.regiondescription AS regiondescr
FROM employeeterritories et
JOIN territories t USING (territoryid)
JOIN region r USING (regionid);

-- 5. Review the above list and add the last name of each employee ID by territory and region description.
SELECT
	DISTINCT(et.employeeid),
	e.lastname,
	t.territorydescription AS territorydescr, 
	r.regiondescription AS regiondescr
FROM employeeterritories et
JOIN territories t USING (territoryid)
JOIN region r USING (regionid)
JOIN employees e USING (employeeid);

-- 6. List the unit prices listed for all products ordered and their categories.
SELECT 
	DISTINCT(p.productname),
	od.unitprice,
	c.categoryname
FROM order_details od
JOIN products p USING (productid)
JOIN categories c USING (categoryid);

-- 7. Review the above list and add the supplier company name of each product.
SELECT 
	DISTINCT(p.productname),
	od.unitprice,
	c.categoryname,
	s.companyname
FROM order_details od
JOIN products p USING (productid)
JOIN categories c USING (categoryid)
JOIN suppliers s USING (supplierid);

-- 8. List the names of the beverage products.
SELECT(productname)
FROM products p
JOIN categories USING (categoryid)
WHERE categoryname = 'Beverages';

-- 9. Review the above list by filtering on the beverage products supplied by the company ‘Bigfoot Breweries’.
SELECT(productname)
FROM products p
JOIN categories USING (categoryid)
JOIN suppliers USING (supplierid)
WHERE categoryname = 'Beverages' AND companyname = 'Bigfoot Breweries';

-- 10. List the products ordered that have been shipped by France.
SELECT
	DISTINCT(productname)
FROM orders o
JOIN order_details od USING (orderid)
JOIN products p USING (productid)
WHERE o.shipcountry = 'France';

