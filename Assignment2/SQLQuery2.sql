-- Thomas Buzaki
-- Assignment 2


--AdventureWorks2019
--Question 1
SELECT COUNT(ProductID)
FROM Production.Product

--Question 2
SELECT COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--Question 3
SELECT DISTINCT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS "CountedProducts"
FROM Production.Product
GROUP BY ProductSubcategoryID

--Question 4
SELECT SUM(CASE WHEN ProductSubcategoryID IS NULL THEN 1 ELSE 0 END)
FROM Production.Product

--Question 5
SELECT SUM(Quantity)
FROM Production.ProductInventory 

--Question 6
SELECT ProductID, SUM(Quantity) AS "TheSum"
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY ProductID
HAVING SUM(Quantity) < 100

--Question 7
SELECT Shelf, ProductID, SUM(Quantity) AS "TheSum"
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100

--Question 8
SELECT AVG(Quantity)
FROM Production.ProductInventory
Where LocationID = 10

--NOTE: For 9 and 10, it mentions having the results "by shelf". I assume this to mean
--the results are ordered by shelf and have done so. 
--Question 9
SELECT ProductID, Shelf, AVG(Quantity) AS "TheAvg"
FROM Production.ProductInventory
GROUP BY Shelf, ProductID
ORDER BY Shelf

--Question 10
SELECT ProductID, Shelf, AVG(Quantity) AS "TheAvg"
FROM Production.ProductInventory
WHERE Shelf NOT LIKE 'N/A'
GROUP BY Shelf, ProductID
ORDER BY Shelf

--Question 11
SELECT Color, Class, AVG(ListPrice) AS "AvgPrice"
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class

--Question 12
SELECT Country.[Name], Province.[Name]
FROM Person.CountryRegion Country
JOIN Person.StateProvince Province ON Country.[CountryRegionCode] = Province.[CountryRegionCode]

--Question 13
SELECT Country.[Name], Province.[Name]
FROM Person.CountryRegion Country
JOIN Person.StateProvince Province ON Country.[CountryRegionCode] = Province.[CountryRegionCode]
WHERE Country.Name LIKE 'Germany' OR Country.Name LIKE 'Canada'
ORDER BY Country.Name


--Northwind
--Question 14
SELECT DISTINCT P.[ProductName]
FROM dbo.Orders O
INNER JOIN dbo.[Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN dbo.Products P ON P.ProductID = OD.ProductID
ORDER BY P.[ProductName]

--QUestion 15
SELECT TOP 5 ShipPostalCode, count(*) AS "Total" 
FROM dbo.Orders
GROUP BY ShipPostalCode
ORDER BY Total DESC

--Question 16
SELECT TOP 5 ShipPostalCode, count(*) AS "Total" 
FROM dbo.Orders
WHERE OrderDate NOT LIKE '1996%'
GROUP BY ShipPostalCode
ORDER BY Total DESC

--Question 17
SELECT City, count(*) AS "Total"
FROM dbo.Customers
GROUP BY City

--Question 18
SELECT City, count(*) AS "Total"
FROM dbo.Customers
GROUP BY City
HAVING count(*) > 2

--Question 19
SELECT C.[CompanyName], O.[OrderDate]
FROM dbo.Orders O
JOIN dbo.Customers C ON C.CustomerID = O.CustomerID
WHERE O.OrderDate > Convert(datetime, '1998-01-01')
ORDER BY O.OrderDate

--Question 20
SELECT C.[CompanyName], MAX(OrderDate)
FROM dbo.Orders O
JOIN dbo.Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName

--Question 21
SELECT C.[CompanyName], COUNT(Quantity) AS "Total"
FROM dbo.[Order Details] OD
JOIN dbo.Orders O ON O.OrderID = OD.OrderID
JOIN dbo.Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
ORDER BY C.CompanyName

--Question 22
SELECT C.[CompanyName], COUNT(Quantity) AS "Total"
FROM dbo.[Order Details] OD
JOIN dbo.Orders O ON O.OrderID = OD.OrderID
JOIN dbo.Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
HAVING COUNT(Quantity) > 100
ORDER BY C.CompanyName

--Question 23
SELECT SU.[CompanyName] "Company Supplier Name",  SH.[CompanyName] "Company Shipper Name"
FROM dbo.Suppliers SU, dbo.Shippers SH
ORDER BY SU.[CompanyName]

--Question 24
SELECT O.[OrderDate], P.[ProductName]
FROM dbo.Orders O
INNER JOIN dbo.[Order Details] OD ON OD.OrderID = O.OrderID
INNER JOIN dbo.Products P ON P.ProductID = OD.ProductID
ORDER BY O.[OrderDate]

--Question 25
SELECT E1.FirstName + ' ' + E1.LastName AS "Name1", E2.FirstName + ' ' + E2.LastName AS "Name2", E1.[Title] AS "Title"
FROM dbo.Employees E1, dbo.Employees E2
WHERE E1.Title = E2.Title AND E1.EmployeeID <> E2.EmployeeID
ORDER BY Title DESC

--Question 26
SELECT E2.FirstName+ ' ' + E2.LastName AS "Manager"
FROM dbo.Employees E1 
INNER JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
GROUP BY E2.FirstName, E2.LastName

--Question 27
SELECT C.[City], C.[CompanyName], C.[ContactName], 'Customer' AS Type
FROM dbo.Customers C
UNION
SELECT S.[City], S.[CompanyName], S.[ContactName], 'Supplier'
FROM dbo.Suppliers S


