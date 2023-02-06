Create Database Northwind
Create TABLE Products 
(
ProductID int NOT NULL PRIMARY KEY,
ProductName varchar(40) NOT NULL DEFAULT '',
SupplierID int NOT NULL,
CategoryID tinyint NOT NULL,
QuantityPerUnit varchar(20) NOT NULL DEFAULT '',
UnitPrice decimal NOT NULL DEFAULT '0',
UnitsInStock smallint NOT NULL DEFAULT '0',
UnitsOnOrder smallint NOT NULL DEFAULT '0',
ReorderLevel smallint NOT NULL DEFAULT '0',
Discontinued bit NOT NULL DEFAULT 0,
)

INSERT INTO Products
values (1,'Chai',1,1,'10 boxes x 20 bags',18,39,0,10,0),
(2,'Chang',1,1,'24 - 12 oz bottles',19,17,40,25,0),
(3,'Aniseed Syrup',1,2,'12 - 550 ml bottles',10,13,70,25,0),
(4,'Chef Anton''s Cajun Seasoning',2,2,'48 - 6 oz jars',22,53,0,0,0),
(5,'Chef Anton''s Gumbo Mix',2,2,'36 boxes',21.35,0,0,0,1),
(6,'Grandma''s Boysenberry Spread',3,2,'12 - 8 oz jars',25,120,0,25,0),
(7,'Uncle Bob''s Organic Dried Pears',3,7,'12 - 1 lb pkgs.',30,15,0,10,0),
(8,'Northwoods Cranberry Sauce',3,2,'12 - 12 oz jars',40,6,0,0,0),
(9,'Mishi Kobe Niku',4,6,'18 - 500 g pkgs.',97,29,0,0,1),
(10,'Ikura',4,8,'12 - 200 ml jars',31,31,0,0,0)


select * from Products


select ProductID, ProductName, UnitPrice
from Products 
where (UnitPrice < 20)
ORDER BY UnitPrice DESC;


select ProductID, ProductName, UnitPrice
from Products 
where (UnitPrice > 15  AND UnitPrice < 25)
ORDER BY UnitPrice ASC;


select ProductName, UnitPrice
from Products
where UnitPrice > (SELECT AVG(UnitPrice) from Products)
ORDER BY UnitPrice;

select ProductName, UnitPrice
from Products
where UnitPrice 
ORDER BY UnitPrice;

select ProductName, UnitPrice
from Products AS a
where 10 >= (select COUNT(UnitPrice)from Products AS b where b.UnitPrice > a.UnitPrice)
ORDER BY UnitPrice DESC;


select COUNT(ProductName)
From Products
Group by Discontinued;


select ProductName, UnitsOnOrder, UnitsInStock
from Products
where UnitsInStock < UnitsOnOrder
ORDER by UnitsInStock ASC;
