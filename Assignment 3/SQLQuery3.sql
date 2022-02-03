--Thomas Buzaki
--Assignment 3

--Question 1
SELECT City
FROM dbo.Customers
UNION
SELECT City
FROM dbo.Employees

--Question 2
--A
SELECT C.City
FROM dbo.Customers C
WHERE C.City NOT IN (SELECT City FROM dbo.Employees)

--B
SELECT C.City
FROM dbo.Customers C, dbo.Employees E
WHERE C.City != E.City

--Question 3
SELECT DISTINCT P.[ProductName], SUM(OD.Quantity) over (partition by P.ProductName) AS "Total"
FROM dbo.[Order Details] OD
INNER JOIN dbo.Products P ON P.ProductID = OD.ProductID
GROUP BY P.[ProductName], OD.Quantity

--Question 4
SELECT C.City , SUM(P.ProductID) "TOTAL" 
FROM dbo.Products P
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID
INNER JOIN dbo.Orders O ON O.OrderID = OD.OrderID
INNER JOIN dbo.Customers C  ON C.CustomerID = O.CustomerID 
GROUP BY C.City

--Question 5
--A
SELECT City 
FROM dbo.Customers 
GROUP BY City 
HAVING count(CustomerID) = 2
UNION
SELECT City 
FROM dbo.Customers 
GROUP BY City 
HAVING count(CustomerID) > 2

--B
SELECT DISTINCT City 
FROM dbo.Customers 
WHERE City IN 
(SELECT City 
FROM dbo.Customers 
GROUP BY City 
HAVING count(CustomerID) >= 2)

--Question 6
SELECT C.City 
FROM dbo.Products P 
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID 
INNER JOIN dbo.Orders O ON O.OrderID = OD.OrderID
INNER JOIN dbo.Customers C  ON C.CustomerID = c.CustomerID 
GROUP BY C.City 
HAVING COUNT(DISTINCT P.ProductID) >= 2
ORDER BY C.City 

--Question 7
SELECT DISTINCT C.CompanyName  
FROM dbo.Orders O 
INNER JOIN dbo.Customers C  ON C.CustomerID = O.CustomerID 
WHERE C.City <> O.ShipCity

--Question 8
SELECT TOP 5  P.ProductName, AVG(P.UnitPrice) "Average Price", C.City  
FROM dbo.Products p 
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID 
INNER JOIN dbo.Orders O ON O.OrderID = OD.OrderID
INNER JOIN dbo.Customers C  ON C.CustomerID = O.CustomerID 
GROUP BY p.ProductName, C.city 
ORDER BY SUM(OD.quantity) DESC 

--Question 9
--A
SELECT City 
FROM dbo.Employees
WHERE City  IN 
(SELECT C.City  
FROM dbo.Customers C 
INNER JOIN dbo.Orders O ON O.CustomerID = C.CustomerID  AND O.EmployeeID IN 
(SELECT EmployeeID 
FROM dbo.Orders) 
GROUP BY C.City 
HAVING COUNT(OrderID) = 0) 

--B
SELECT C.City , COUNT(O.OrderID) 
FROM dbo.Customers C 
LEFT JOIN dbo.Orders O ON O.CustomerID  = C.customerid 
LEFT JOIN dbo.Employees E ON E.EmployeeID = O.EmployeeID  
GROUP BY C.City 
HAVING COUNT(O.OrderID) =0 

--Question 10
SELECT DISTINCT C.city 
FROM orders O 
INNER JOIN customers C ON O.CustomerID = C.CustomerID 
WHERE C.city IN 
(SELECT TOP 1 C.city  
FROM dbo.Products P 
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID 
INNER JOIN dbo.Orders O ON O.OrderID = OD.OrderID
INNER JOIN dbo.Customers C  ON C.CustomerID = O.CustomerID 
GROUP BY C.City 
ORDER BY COUNT(O.OrderID) DESC)
AND C.City IN 
(SELECT TOP 1 C.City 
FROM dbo.Products P 
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID 
INNER JOIN dbo.Orders O ON O.OrderID = OD.OrderID
INNER JOIN dbo.Customers C  ON C.CustomerID = O.CustomerID 
GROUP BY C.City 
ORDER BY COUNT(OD.ProductID) DESC)

--Question 11
--One way to remove duplicate rows is to use GROUP BY and Having. First you 
--use GROUP BY to sort your results into the group desired. Once those groups
--are formed, we can then use HAVING to implement a check using COUNT(*) >1.
--This check will look to see if there are more than 1 instance of your results
--and remove any results that occur more than once. 

