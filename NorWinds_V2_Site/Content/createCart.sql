CREATE TABLE [dbo].[Cart] (
    [CartItemID]  INT         IDENTITY (1, 1) NOT NULL,
    [ProductID]   INT         NOT NULL,
    [CustomerID]  NCHAR (100) NOT NULL,
    [SessionID]   NCHAR (100) NOT NULL,
    [Quantity]    INT         NOT NULL,
    [ProductName] NCHAR (100) NOT NULL,
    [UnitPrice]   FLOAT (53)  NULL,
    [SubTotal]    FLOAT (53)  NULL
);

