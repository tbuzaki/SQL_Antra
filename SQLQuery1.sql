--Thomas Buzaki
--Assignment 1

--Question 1
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

--Question 2
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice != 0

--Question 3
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL

--Question 4
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

--Question 5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL AND ListPrice > 0

--Question 6
SELECT Name, Color, Name + ' ' +Color AS [Name/Color]
FROM Production.Product
WHERE Color IS NOT NULL

--Question 7
--Note: Not too clear on the question. I don't know if you want it to 
--match exactly as it is shown, or just make any query produce the data
--requested. 
SELECT TOP 6 Name, Color, Name + ' ' +Color AS [Name/Color]
FROM Production.Product
WHERE Color IS NOT NULL

--Question 8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID > 400 AND ProductID < 500 

--Question 9
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Black' OR Color = 'Blue' 

--Question 10
--Note: Not too clear on question. When it asks for "result set",
--does this mean it wants all columns or just the one relevant "Name" column.
SELECT Name
FROM Production.Product
WHERE Name LIKE'S%'

--Question 11
--Note: In the given example set, it only shows a handful of items, all beginning
--with the letter "S". It is not clear if we are meant to build off question 10
--or to order the entire data set. I continued with question 10 since it was
--the most similar.
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE'S%'
ORDER BY Name  

--Question 12
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE'A%' OR Name LIKE 'S%'
ORDER BY Name 

--Question 13
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
ORDER BY Name 

--Question 14
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE Color IS NOT NULL AND ProductSubcategoryID IS NOT NULL
