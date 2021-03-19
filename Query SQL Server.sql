------------------------------------------Membuat Database di SQL Server
--Query :
CREATE DATABASE Departement_Stores

------------------------------------------Membuat Table pada Database
--Query :
CREATE TABLE Customer
(
	CustomerId CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(50) NOT NULL,
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100),

	CONSTRAINT checkCustomerId CHECK(LEN(CustomerId) = 5 and CustomerId LIKE 'C[0-9][0-9][0-9][0-9]')
)

CREATE TABLE Product
(
	ProductId CHAR(5) PRIMARY KEY,
	ProductName VARCHAR(100) NOT NULL,
	CategoryProduct VARCHAR(10),
	Price NUMERIC(11,2),
	

	CONSTRAINT checkProductId CHECK(LEN(ProductId) = 5 and ProductId LIKE 'P[0-9][0-9][0-9][0-9]'),
	CONSTRAINT checkCategoryProduct CHECK(CategoryProduct = 'Male' or CategoryProduct = 'Female')
)

CREATE TABLE SellTransaction
(
	TransactionId CHAR(5) PRIMARY KEY,
	CustomerId CHAR(5) NOT NULL REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,
	ProductId CHAR(5) NOT NULL REFERENCES Product ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity NUMERIC(11,2),
	TransactionDate DATE,
	TransactionTime TIME,
	TotalPrice NUMERIC(11,2),

	CONSTRAINT checkTransactionId CHECK(LEN(TransactionId) = 5 and TransactionId LIKE 'T[0-9][0-9][0-9][0-9]')
)

------------------------------------------Insert Data To Table
--Query:
INSERT INTO Customer VALUES
('C0001', 'Andi', '081323343455', 'Manglayang Street'),
('C0002', 'Adi', '0813233444343', 'Beringin Street'),
('C0003', 'Endi', '081323345553', 'Setiabudi Street'),
('C0004', 'Udi', '081323345344', 'Cibiru Street'),
('C0005', 'Baja', '08132334554', 'Kemang Street'),
('C0006', 'Budi', '081323343443', 'Bunar Street'),
('C0007', 'Endi', '081323345553', 'Margahayu Street'),
('C0008', 'Anji', '0813233453333', 'Ledeng Street'),
('C0009', 'Edi', '0813233422253', 'Cilandak Street'),
('C0010', 'Barak', '0813233111553', 'Lembang Street')

INSERT INTO Product VALUES
('P0001', 'Bedak', 'Female', '100000'),
('P0002', 'Lipstik', 'Female', '200000'),
('P0003', 'Kaos Pria', 'Male', '100000'),
('P0004', 'Jeans Pria', 'Male', '200000'),
('P0005', 'Baju Cewe', 'Female', '100000'),
('P0006', 'Celana Cewe', 'Female', '200000'),
('P0007', 'Masker', 'Female', '50000')

INSERT INTO SellTransaction VALUES
('T0001','C0003','P0002','2','2021-01-02','13:32:00','400000'),
('T0002','C0005','P0001','4','2021-01-03','10:01:00','400000'),
('T0003','C0006','P0001','2','2021-01-03','15:30:00','200000'),
('T0004','C0001','P0003','3','2021-01-03','18:50:43','300000'),
('T0005','C0003','P0003','1','2021-01-02','07:15:05','100000'),
('T0006','C0003','P0001','2','2021-01-03','10:02:00','200000'),
('T0007','C0001','P0002','1','2021-01-03','05:15:30','200000'),
('T0008','C0002','P0005','4','2021-01-03','09:01:00','400000'),
('T0009','C0002','P0004','5','2021-01-03','10:00:00','1000000'),
('T0010','C0005','P0004','2','2021-01-02','11:10:10','400000'),
('T0011','C0005','P0002','2','2021-01-02','00:10:10','400000'),
('T0012','C0006','P0002','2','2021-01-03','01:10:10','200000'),
('T0013','C0007','P0004','3','2021-01-03','03:10:10','600000'),
('T0014','C0008','P0001','1','2021-01-02','16:10:10','100000'),
('T0015','C0005','P0002','2','2021-01-02','19:10:10','400000'),
('T0016','C0006','P0003','3','2021-01-02','21:10:10','300000'),
('T0017','C0008','P0005','2','2021-01-02','23:10:10','200000')


------------------------------------------Question No 2. Create Query to get best seller product for male and female
--Query :
SELECT TOP 1 Product.ProductId,Product.CategoryProduct,Product.ProductName,SUM(Quantity) AS [Quantity],SUM(TotalPrice) AS [TotalSales] 
FROM Product
JOIN SellTransaction ON SellTransaction.ProductId = Product.ProductId
WHERE Product.CategoryProduct = 'Male'
GROUP BY Product.ProductId,Product.CategoryProduct, Product.ProductName
ORDER BY Quantity DESC

SELECT TOP 1 Product.ProductId,Product.CategoryProduct,Product.ProductName,SUM(Quantity) AS [Quantity],SUM(TotalPrice) AS [TotalSales]
FROM Product
JOIN SellTransaction ON SellTransaction.ProductId = Product.ProductId
WHERE Product.CategoryProduct = 'Female' 
GROUP BY Product.ProductId,Product.CategoryProduct, Product.ProductName 
ORDER BY Quantity DESC


------------------------------------------Question No 3. create query to get customer that spends the most money
--Answer :
SELECT TOP 1 C.CustomerId,C.CustomerName,SUM(TotalPrice) AS [TotalSpends]
FROM Customer AS C
JOIN SellTransaction AS S ON S.CustomerId = C.CustomerId
GROUP BY C.CustomerId,C.CustomerName
ORDER BY TotalSpends DESC


------------------------------------------Question No 4. create query to show number of transactions for every 2 hours
--Answer :
SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 00:00 - 02:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '00:00:00' AND '02:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 02:01 - 04:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '02:01:00' AND '04:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 06:01 - 08:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '06:01:00' AND '08:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 08:01 - 10:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '08:01:00' AND '10:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 10:01 - 12:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '10:01:00' AND '12:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 12:01 - 14:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '12:01:00' AND '14:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 14:01 - 16:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '14:01:00' AND '16:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 16:01 - 18:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '16:01:00' AND '18:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 18:01 - 20:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '18:01:00' AND '20:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 20:01 - 22:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '20:01:00' AND '22:00:00'
GROUP BY TransactionDate

SELECT TransactionDate, COUNT(TransactionId) AS [Count Transaction 22:01 - 24:00]
FROM SellTransaction
WHERE TransactionTime BETWEEN '22:01:00' AND '24:59:00'
GROUP BY TransactionDate

