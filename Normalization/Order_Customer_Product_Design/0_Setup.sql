USE [master];
GO


IF EXISTS (SELECT * FROM sys.sysdatabases WHERE[Name] = 'OrdersDatabase')
	BEGIN
		DROP DATABASE OrdersDatabase
	END;
GO

CREATE DATABASE OrdersDatabase;
GO
ALTER AUTHORIZATION ON DATABASE::OrdersDatabase TO [sa];
GO

USE OrdersDatabase;
GO

--Create Customers and populate table
CREATE TABLE Customers
(CustomerID INT NOT NULL
,LastName VARCHAR (50) NOT NULL
,FirstName VARCHAR (50) NOT NULL
CONSTRAINT PK_Customers PRIMARY KEY (CustomerID));
GO

INSERT INTO Customers
VALUES (1,'Lynn', 'Tsoflias')
INSERT INTO Customers
VALUES (2,'Amy','Alberts')
INSERT INTO Customers
VALUES (3,'Rachel','Valdez')
INSERT INTO Customers
VALUES (4,'Jae','Pak');
GO

--Create CustomerDetails and populate table
CREATE TABLE CustomerDetails
(CustomerID INT NOT NULL
,[Address] VARCHAR (50) NOT NULL
,City VARCHAR (50) NOT NULL
,PostalCode VARCHAR (50) NOT NULL
,DateOfBirth DATETIME NULL
CONSTRAINT PK_CustomerDetails PRIMARY KEY (CustomerID));
GO

INSERT INTO CustomerDetails
VALUES (1,'1970 Napa Ct', 'Seattle','91932','06/02/1980')
INSERT INTO CustomerDetails
VALUES (2,'9833 Mt. Dias Blv', 'Chicago','97321', '08/08/1966')
INSERT INTO CustomerDetails
VALUES (3,'7484 Roundtree Drive','Boston', '94109','12/14/1967')
INSERT INTO CustomerDetails
VALUES (4,'9539 Glenside Dr','Seattle','91977','05/23/1956');
GO

--Create and populate Orders table
CREATE TABLE Orders
(OrderID INT NOT NULL
,CustomerID INT NOT NULL
,DateOfBirth DATETIME NOT NULL
CONSTRAINT PK_Orders PRIMARY KEY (OrderID));
GO

INSERT INTO Orders
VALUES (101,2, GETDATE())
INSERT INTO Orders
VALUES (102,3,GETDATE())
INSERT INTO Orders
VALUES (103,1,GETDATE())
INSERT INTO Orders
VALUES (104,4,GETDATE());
GO

--Create and populate Products table
CREATE TABLE Products
(ProductID INT NOT NULL
,ProductName VARCHAR (50) NOT NULL
,Size VARCHAR (5) NOT NULL
,Color VARCHAR (25) NOT NULL
CONSTRAINT PK_Products PRIMARY KEY (ProductID));
GO

INSERT INTO Products
VALUES (11,'Full-Finger Gloves, M', 'M', 'Black')
INSERT INTO Products
VALUES (22,'Full-Finger Gloves, L', 'L', 'Black')
INSERT INTO Products
VALUES (33,'Classic Vest, S', 'S', 'Yellow')
INSERT INTO Products
VALUES (44,'Classic Vest, M', 'M', 'Yellow');
GO

--Create and populate LineItems table
CREATE TABLE LineItems
(OrderID INT NOT NULL
,ProductID INT NOT NULL
,UnitPrice MONEY NOT NULL
,Quantity SMALLINT NOT NULL
CONSTRAINT PK_LineItems PRIMARY KEY (OrderID,ProductID));
GO

INSERT INTO LineItems
VALUES (101,11,15.00,1)
INSERT INTO LineItems
VALUES (101,44,30.00,1)
INSERT INTO LineItems
VALUES (102,44,30.00,1)
INSERT INTO LineItems
VALUES (103,33,30.00,2)
INSERT INTO LineItems
VALUES (103,22,15.00,1)
INSERT INTO LineItems
VALUES (104,44,30.00,1)
INSERT INTO LineItems
VALUES (104,11,15.00,1)
INSERT INTO LineItems
VALUES (104,33,30.00,1);
GO


