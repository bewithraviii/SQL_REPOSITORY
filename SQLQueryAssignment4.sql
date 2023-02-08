Select * from Categories
Select * from CustomerCustomerDemo
Select * from CustomerDemographics
Select * from Customers
Select * from Employees
Select * from EmployeeTerritories
Select * from [Order Details]
Select * from Orders
Select * from Products
Select * from Region
Select * from Shippers
Select * from Suppliers
Select * from Territories








--Query-1
CREATE PROCEDURE spAvgvalueFreight 
@CustomerId nvarchar(5),
@AvgFreight money output

AS
BEGIN 
SELECT @AvgFreight = AVG(Freight) 
FROM Orders 
Where Orders.CustomerID = @CustomerId ;
END

CREATE TRIGGER OrdersModifyOnInsert
ON Orders 
INSTEAD OF INSERT 
AS
BEGIN 
	DECLARE @AvgFreight money
	DECLARE @Freight money
	DECLARE @CustID nvarchar(5)
	SELECT @Freight = Freight FROM inserted
	SELECT @CustID = CustomerID FROM inserted
	--select all the variables from the Orders coloumn and assign it value in Else Part for the insertaion
	EXEC spAvgvalueFreight @CustId , @AvgFreight OUTPUT 

	IF (@Freight < @AvgFreight)
	BEGIN
		PRINT 'Freight value is lower than average value...'
	END
	--ELSE 
	--BEGIN
	--	INSERT INTO Orders VALUES ()
	--END
 END

 CREATE TRIGGER OrdersModifyOnUpdate
 ON Orders 
 INSTEAD OF UPDATE 
 AS
 BEGIN 
	DECLARE @AvgFreight money
	DECLARE @Freight money
	DECLARE @CustID nchar(5)
	SELECT @Freight = Freight FROM inserted
	SELECT @CustID = CustomerID FROM inserted

	EXEC spAvgvalueFreight 'RATTC' , @AvgFreight OUTPUT 

	IF (@Freight < @AvgFreight)
	BEGIN
		PRINT 'Freight value is lower than average value...';
	END
 END

INSERT INTO Orders VALUES (N'RATTC',1,'5/6/1998','6/3/1998',NULL,2,228.53,N'Rattlesnake Canyon Grocery',N'2817 Milton Dr.',N'Albuquerque',N'NM',N'87110',N'USA')

select * from Orders where CustomerID = 'RATTC' 

DECLARE @AvgFreight1 money
EXEC spAvgvalueFreight 'RATTC' , @AvgFreight1 OUTPUT
PRINT @AvgFreight1








--Query2
create procedure EmployeeSalesbyCountry
@Beginning_Date DateTime, 
@Ending_Date DateTime 
AS
SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, [Order Details].Quantity AS "SaleQuantity", [Order Details].ProductID AS "Products ID"
FROM Employees INNER JOIN 
	(Orders INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
ORDER BY Orders.ShippedDate ASC;

Execute EmployeeSalesbyCountry @Beginning_Date = '1996-07-04',@Ending_Date = '1996-08-4';





--Query3
create procedure salesbyyear
@startdate Datetime,
@enddate Datetime
AS
select Orders.ShippedDate,Orders.OrderID, [Order Details].Quantity AS "SaleQuantity", [Order Details].ProductID AS "Products ID", DATENAME(yy,ShippedDate) AS Year
From Orders
inner join [Order Details]
on Orders.OrderID = [Order Details].OrderID
where Orders.ShippedDate BETWEEN @startdate AND @enddate
ORDER BY Orders.ShippedDate ASC;

Execute salesbyyear @startdate = '1996-07-04',@enddate = '1997-07-04';





--Query4
create procedure salebycategory
@category nvarchar(40)
AS
Select Products.ProductName, Categories.CategoryName, Products.ProductID, Categories.CategoryID,[Order Details].Quantity AS "SaleQuantity", [Order Details].ProductID AS "Products ID"
from Categories
inner join (Products inner join [Order Details] on Products.ProductID = [Order Details].ProductID)
on Categories.CategoryID = Products.CategoryID
where Categories.CategoryName = @category; 

Execute salebycategory @category = [Dairy Products];





--Query5
create procedure tenexpensiveproduct
AS
select TOP(10) Products.ProductName as [Ten Most Expensive Product], Products.UnitPrice as "Price"
from Products 
Order by Products.UnitPrice DESC;

Execute tenexpensiveproduct;







--Query6
CREATE PROCEDURE [Insert Customer Order Delete] 
(
@OrderID int, 
@ProductID int,
@UnitPrice money,
@Quantity smallint,
@Discount real
)
AS
BEGIN
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)
END

Execute [Insert Customer Order Delete] @OrderID = 10248, @ProductID = 11,@UnitPrice = 14.40, @Quantity = 5, @Discount = 0.03;


--@OrderID = 10248, @ProductID = 1,@UnitPrice = 14.40, @Quantity = 5, @Discount = 0.03

--SELECT * FROM [Order Details]
--where [Order Details].OrderID = 10248




--Query7
ALTER PROCEDURE [Update Customer Order Delete]
(
@OrderID int, 
@ProductID int,
@UnitPrice money,
@Quantity smallint,
@Discount real
)
AS
BEGIN
UPDATE [Order Details] 
SET UnitPrice = @UnitPrice, Quantity = @Quantity, Discount = @Discount
WHERE OrderID = @OrderID AND ProductID = @ProductID
END

Execute [Update Customer Order Delete] @OrderID = 10248, @ProductID = 11,@UnitPrice = 15, @Quantity = 12, @Discount = 0.01;

--Select * from [Order Details]
--where [Order Details].OrderID = 10248 And [Order Details].ProductID = 11 