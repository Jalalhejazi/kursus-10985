USE OrdersDatabase;
GO
--Add foreign key to Orders table
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID);
GO
--Test foreign key on Orders. This INSERT statement should work.
INSERT INTO Orders
VALUES (105,2, GETDATE());
GO
--Test foreign key on Orders. This INSERT statement shouldn't work
--because the CustomerID 5 doesn't exist in the Customers table.
INSERT INTO Orders
VALUES (106,5, GETDATE());
GO

--Add foreign key to CustomerDetails table
ALTER TABLE CustomerDetails
ADD CONSTRAINT FK_CustomerDetails_Customers FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID);
GO

--Test foreign key on CustomerDetails. The INSERT should fail because
--the CustomerID 5 doesn't exist in the Customers table.
INSERT INTO CustomerDetails
VALUES (5,'9832 Mt. Dias Blv', 'Chicago','97321', '08/09/1970');
GO

--Add first foreign key to LineItems table
ALTER TABLE LineItems
ADD CONSTRAINT FK_LineItems_Orders FOREIGN KEY (OrderID)
REFERENCES Orders (OrderID);
GO

--Test FK_LineItems_Orders foreign key. This INSERT statement should work.
INSERT INTO LineItems
VALUES (101,33,30.00,1);
GO
--Test FK_LineItems_Orders foreign key. This INSERT statement shouldn't work
--because the OrderID 106 doesn't exist in the Orders table.
INSERT INTO LineItems
VALUES (106,44,30.00,1);
GO

--Add second foreign key to LineItems table
ALTER TABLE LineItems
ADD CONSTRAINT FK_LineItems_Products FOREIGN KEY (ProductID)
REFERENCES Products (ProductID);
GO

--Test the FK_LineItems_Products foreign key. This first INSERT statement should work.
INSERT INTO LineItems
VALUES (102,22,15.00,1);
GO
--Test the FK_LineItems_Products foreign key. This INSERT statement shouldn't work
--because the ProductID 66 doesn't exist in the products table.
INSERT INTO LineItems
VALUES (104,66,30.00,1);
GO