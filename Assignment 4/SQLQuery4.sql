--Thomas Buzaki
--Assignment 4

--Question 1
CREATE VIEW view_product_order_Buzaki AS 
SELECT P.ProductName, COUNT(OD.Quantity) AS "Count"
FROM dbo.Products P
INNER JOIN dbo.[Order Details] OD ON OD.ProductID = P.ProductID
GROUP BY P.ProductName

--Question 2
CREATE PROC sp_product_order_quantity_Buzaki
@ID INT, @TOTAL INT OUT 
AS
BEGIN
SELECT @ID = view_product_order_quantity_Buzaki.ProductID, @TOTAL = view_product_order_quantity_Buzaki.[Count]
FROM view_product_order_quantity_Buzaki
WHERE view_product_order_quantity_Buzaki.ProductID = @ID
END
DECLARE @ID INT, @TOTAL INT
EXEC sp_product_order_quantity_Buzaki 2, @TOTAL OUT
PRINT @TOTAL

--Question 3
CREATE PROC sp_product_order_city_Buzaki(@ProductName VARCHAR(50), @OrderCity VARCHAR(50) OUT) 
AS
BEGIN
SELECT @ProductName = DT.ProductName 
FROM(SELECT TOP 5 Derive.ProductID, Derive.ProductName 
FROM (SELECT P.ProductID, P.ProductName, SUM(OD.Quantity) "Total" 
FROM Products P 
INNER JOIN [Order Details] OD ON P.ProductID = OD.ProductID 
GROUP BY P.ProductID, P.ProductName) AS "Derive" 
ORDER BY Derive.Total DESC) DT 
LEFT JOIN( SELECT * 
FROM (SELECT Derive2.ProductID, Derive2.City, RANK() OVER(PARTITION BY ProductID 
ORDER BY "Total" DESC) "Rank" 
FROM(SELECT P.ProductID, C.City, SUM(OD.Quantity) AS "Total" 
FROM dbo.Customers C 
INNER JOIN dbo.Orders O ON C.CustomerID = O.CustomerID 
LEFT JOIN [Order Details] OD ON O.OrderID = OD.OrderID 
LEFT JOIN dbo.Products P ON OD.ProductID = P.ProductID 
GROUP BY P.ProductID, C.City ) "Derive2" ) "DT2" 
WHERE DT2.Rank=1) X ON DT.ProductID = X.ProductID WHERE X.City = @OrderCity 
END

--Question 4
--NOTE: Run these first
CREATE TABLE PeopleBuzaki(id INT, NAME CHAR(20),cityid INT)
CREATE TABLE CityBuzaki(cityid INT,city CHAR(20))
INSERT INTO PeopleBuzaki(id,NAME,cityid)VALUES(1,'Aaron Rodgers',2)
INSERT INTO PeopleBuzaki(id,NAME,cityid)VALUES(2,'Russell Wilson',1)
INSERT INTO PeopleBuzaki(id,NAME,cityid)VALUES(3,'Jody Nelson',2)
INSERT INTO CityBuzaki(cityid,city)VALUES(1,'Settle')
INSERT INTO CityBuzaki(cityid,city)VALUES(2,'Green Bay')

--NOTE: After running the above, run the below seperately 
CREATE VIEW PackersBuzaki AS 
SELECT P.id, P.name 
FROM PeopleBuzaki P 
INNER JOIN CityBuzaki C ON P.CityID = C.CityID 
WHERE C.City='Green bay'

--NOTE: After running the above, run the below to view the table.
SELECT * 
FROM dbo.PackersBuzaki

--NOTE: After running the above, run the below to finish the question.
DROP TABLE PeopleBuzaki
DROP TABLE CityBuzaki
DROP VIEW PackersBuzaki

--Question 5:
--NOTE: Run this section first.
CREATE PROC sp_birthday_employees_Buzaki AS
SELECT E.FirstName + ' ' + E.LastName AS "Employees With Feb Birthday"
FROM dbo.Employees E
WHERE MONTH(BirthDate) = 2

--NOTE: After running the above section, run this line to check the list.
EXEC sp_birthday_employees_Buzaki

--NOTE: Run this code if you need to delete the PROC
DROP PROC sp_birthday_employees_Buzaki

--Question 6
--We can use the EXCEPT command to check the two tables against each other. You would 
--SELECT * FROM Table A EXCEPT SELECT * FROM Table B. Using this, it will tell us what
--rows are in Table B but not in Table A.