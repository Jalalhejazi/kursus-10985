USE OrdersDatabase;
GO

--Test foreign key on Orders. This DELETE statement shouldn't work
--because the CustomerID 2 has orders.
DELETE Customers
WHERE CustomerID = 2;
GO

--Add cascade delete to the CustomerDetails:Customers constraint
ALTER TABLE CustomerDetails
DROP CONSTRAINT FK_CustomerDetails_Customers;
GO
ALTER TABLE CustomerDetails
ADD CONSTRAINT FK_CustomerDetails_Customers FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID) ON DELETE CASCADE;
GO

--Create a default constraint on the CustomerID column in the Orders table
ALTER TABLE Orders
ADD CONSTRAINT DEF_CustomerID 
DEFAULT 0 FOR CustomerID;
GO

--Test the default constraint
INSERT INTO Customers
VALUES(0, 'Not Applicable', 'Not Applicable');
GO

--Modify the Customers:Orders constraint to set default values on delete
ALTER TABLE Orders
DROP CONSTRAINT FK_Orders_Customers;
GO
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID) ON DELETE SET DEFAULT;
GO

--This DELETE statement should now work.
DELETE Customers
WHERE CustomerID = 2;
GO

--Test the ON DELETE clause
SELECT * FROM Orders;
GO

--Test that the Customer details have been deleted
SELECT * FROM CustomerDetails;
GO
