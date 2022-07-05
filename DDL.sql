
/*			SQL Project Name : Travels and Tours Management System in Bangladesh(TTMSB)
							   Trainee Name : Rakibul Hasib  
						    	  Trainee ID : 1269816      
						    Batch ID : ESAD-CS/PNTL-A/51/01 
--======================================================================================================--*/

----------CONTENTS---------
/*
SECTION 01: CREATED A DATABASE NAME [TTMSB]
SECTION 02: Created Appropriate Tables For The Database
SECTION 03: Apply Some Modifying Statement (ALTER, ADD, DROP)
SECTION 04: Created Clustered & Non-Clustered Index
SECTION 05: Created Views
SECTION 06:CREATED STORE PROCEDURE
SECTION 07:Created UDF Function
SECTION 08: Created Trigger
SECTION 09: Created a TRANSACTION
*/

																															
--=====================================   START OF DDL SCRIPT   =======================================--
USE master
Go

DROP DATABASE IF EXISTS TTMSB
GO

--===SECTION 01: CREATED A DATABASE NAME [TTMSB]===
CREATE DATABASE TTMSB
ON
(
	NAME= 'TTMSB_data',
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TTMSB_data.mdf',
	SIZE=50MB,
	MAXSIZE=100MB,
	FILEGROWTH=10MB
)
LOG ON
(
NAME= 'TTMSB_log',
	FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TTMSB_log.ldf',
	SIZE=15MB,
	MAXSIZE=30MB,
	FILEGROWTH=5%
)
GO


-- USE DATABASE
USE TTMSB
GO
--=============================================End of SECTION 01====================================================--


/*SECTION 02: Created Appropriate Tables For The Database*/


--Created sequence for agency table
CREATE SEQUENCE [DBO].[Sequence]
AS INT
START WITH 1
INCREMENT BY 1
GO
--Created a Table Name [agency]

CREATE TABLE agency
(
	id INT PRIMARY KEY,
	agencyid UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
	agencyName NVARCHAR(40) NOT NULL,
	location NVARCHAR(10) DEFAULT 'Dhaka'
)
GO

--Created a Table Name [client]
CREATE TABLE client
(
	clientId INT IDENTITY PRIMARY KEY,
	clientName NVARCHAR(30) NOT NULL,
	phoneNo INT NOT NULL,
	[address] NVARCHAR(50) NOT NULL,
	city NVARCHAR(15) NULL DEFAULT 'Dhaka',
	gender NVARCHAR(15) NOT NULL,
	NID CHAR(13) NOT NULL UNIQUE CHECK(NID LIKE'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	email NVARCHAR(40) NULL
)
GO


--Created a Table Name [spot]

CREATE TABLE spot
(
	spotId INT IDENTITY PRIMARY KEY,
	spotName NVARCHAR(20) NOT NULL,
	[location] NVARCHAR(20) NOT NULL,
	tourDuration INT NOT NULL,
	startingDate DATE NOT NULL DEFAULT GETDATE(),
	endingDate DATE NOT NULL,
	spotPrice MONEY NOT NULL,
	discount FLOAT NOT NULL DEFAULT 0,
	available BIT NOT NULL
)
GO

--Created a Table Name [package]
CREATE TABLE package
(
	packageId INT IDENTITY PRIMARY KEY,
	packageName NVARCHAR(50) NOT NULL,
	[location] NVARCHAR(20) NOT NULL,
	tourDuration INT NOT NULL,
	startingDate DATE NOT NULL DEFAULT GETDATE(),
	endingDate DATE NOT NULL,
	packagePrice MONEY NOT NULL,
	discount FLOAT NOT NULL DEFAULT 0,
	available BIT NOT NULL
)
GO


--Created a Table Name [hotel]
CREATE TABLE hotel
(
	hotelId INT IDENTITY PRIMARY KEY,
	hotelName NVARCHAR(30) NOT NULL
)
GO

--Created a Table Name[Transport]
CREATE TABLE transportation
(
	transportId INT IDENTITY PRIMARY KEY,
	transportName NVARCHAR(25) NOT NULL
)
GO


--Created a Table Name [SpotBookingDetails]
CREATE TABLE SpotBookingDetails
(
	bookingId INT IDENTITY PRIMARY KEY,
	agencyId INT REFERENCES agency(id),
	clientId INT REFERENCES client(clientId),
	spotId INT REFERENCES spot(spotId),
	hotelId INT REFERENCES hotel(hotelId),
	transportId INT REFERENCES transportation(transportId),
	bookingDate DATE NOT NULL,
	spotPrice MONEY NOT NULL,
	travellerNumber INT NOT NULL,
	discount FLOAT NOT NULL DEFAULT 0,
	totalPrice as (spotPrice*travellerNumber*(1-discount))
)
GO




--Created a Table Name [packageBookingDetails]


CREATE TABLE packageBookingDetails
(
	bookingId INT IDENTITY PRIMARY KEY,
	agencyId INT REFERENCES agency(id),
	clientId INT REFERENCES client(clientId),
	packageId INT REFERENCES package(packageId),
	hotelId INT REFERENCES hotel(hotelId),
	transportId INT REFERENCES transportation(transportId),
	bookingDate DATE NOT NULL,
	packagePrice MONEY NOT NULL,
	travellerNumber INT NOT NULL,
	discount FLOAT NOT NULL DEFAULT 0,
	totalPrice as (packagePrice*travellerNumber*(1-discount))
)
GO
--=============================================End of SECTION 02====================================================--


/*SECTION 03: Apply Some Modifying Statement (ALTER, ADD, DROP)*/

-- SQL Server Add New Column

ALTER Table SpotBookingDetails
    ADD class NVARCHAR (30) NULL
GO  

-- SQL Server Drop Column

ALTER TABLE SpotBookingDetails
    DROP COLUMN class
GO

-- SQL Server Modify Column Data Type
ALTER TABLE client
ALTER COLUMN  
 clientName VARCHAR (100) NOT NULL
GO
--=============================================End of SECTION 03====================================================--


/*SECTION 04: Created Clustered & Non-Clustered Index*/

--create a table for using clustered Index
CREATE TABLE testIndex
(
	id INT,
	name VARCHAR(20)
)
GO

--Created a clustered Index on testIndex
CREATE CLUSTERED INDEX IX_Id
ON testIndex(id)
GO

--Created a Non-Clustered Index on client
CREATE NONCLUSTERED INDEX IX_Client_Name
ON client(clientName)
GO
--=============================================End of SECTION 04====================================================--


/*SECTION 05: Created Views*/

--View-01(Create a view on transportation table)
CREATE VIEW v_transportation
AS
SELECT * FROM transportation
GO

--Create a view for using Insert Data
--View-02
CREATE VIEW vClientInformation
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT 
	clientId,
	clientName,
	phoneNo,
	address,
	city,
	gender,
	email
FROM dbo.client
GO


--View-03(Created a view to see all spot and package name)

CREATE VIEW vAllSpotAndPackageName
WITH ENCRYPTION,SCHEMABINDING
AS
SELECT 
spotName,
packageName
FROM dbo.spot s
INNER JOIN dbo.SpotBookingDetails sbd ON sbd.spotId=s.spotId
INNER JOIN dbo.package p ON p.packageId=sbd.spotId
GO

--=============================================End of SECTION 05====================================================--

/*SECTION 06:CREATED STORE PROCEDURE*/
--Procedure 01
CREATE PROC spTransportationAll
AS
SELECT 
	transportId,
	transportName 
FROM transportation
GO


--procedure 02
CREATE PROC spPackageAvailable
AS
SELECT 
	packageId,
	packageName,
	location,
	tourDuration,
	startingDate,
	endingDate,
	packagePrice,
	discount,
	available
FROM package
WHERE available=1
GO


--procedure 03
--input Parameters in store procedure
CREATE PROC spClientCity @city NVARCHAR(15)
AS
SELECT 
	clientId,
	clientName,
	phoneNo,
	[address],
	city,
	gender,
	NID,
	email
FROM client
WHERE city=@city
GO


--procedure 04

--A Stored Procedure for inserting DATA in hotel
CREATE PROC spInsertHotel @hotelName NVARCHAR(30)
AS
BEGIN
	INSERT INTO hotel(hotelName) VALUES(@hotelName)
END
GO

--procedure 05
--Insert with Retrun
CREATE PROC spTestIndexInsertWithReturn @id INT,
										@Name VARCHAR(20)
AS
DECLARE @tid INT
INSERT INTO testIndex(id,name) VALUES
(@id,@name)
SELECT @Id=IDENT_CURRENT ('testIndex')
RETURN @tid
GO


--procedure 06
--Default Value With parameters
CREATE PROC spTestIndexInsertWithDefaultvalues @id INT NULL,
										    	@name VARCHAR(20)='Hasib'							 
AS
INSERT INTO testIndex(id,name) VALUES
(@id,@name)
GO


--Procedure
--PassingOutput Parameters
CREATE PROC spTestIndexInsertWithReturn02 @id INT,
										  @Name VARCHAR(20),
										  @tId INT OUTPUT
AS
INSERT INTO testIndex(id,name) VALUES
(@id,@name)
SELECT @Id=IDENT_CURRENT ('testIndex')
GO
--=============================================End of SECTION 06====================================================--

/*SECTION 07:Created UDF Function*/

--Function 01(Scalar Valued Function)
CREATE FUNCTION fnSpotdiscont(@spotPrice MONEY,@travellerNumber INT,@discount FLOAT)
RETURNS MONEY 
AS
BEGIN 
	DECLARE @totalDiscount MONEY
	SET @totalDiscount=@spotPrice*@travellerNumber*@discount
	RETURN @totalDiscount
END
GO


--Function 02(Simple/Single Table Valued Function)
CREATE FUNCTION fnAllSummary(@Year INT,@Month INT)
RETURNS TABLE
AS
RETURN
(
	SELECT 
	SUM(spotPrice*travellerNumber) AS 'Total Price',
	SUM(spotPrice*travellerNumber*discount) As 'Discount',
	SUM(spotPrice*travellerNumber*(1-discount)) As 'Net Price'
	FROM SpotBookingDetails
	WHERE YEAR(bookingDate)=@Year AND MONTH(bookingDate)=@month
)
GO

--Function 03(Multi Statement Table Valued Function)
CREATE FUNCTION fPriceDetails(@Year INT,@Day INT)
RETURNS @PriceDetails TABLE
(
	spotName NVARCHAR(20),
	totalPrice MONEY,
	discount MONEY,
	netPrice Money
)
AS
BEGIN
	INSERT INTO @PriceDetails
	SELECT  
	s.spotName,
	SUM(s.spotPrice*spd.travellerNumber),
	SUM(s.spotPrice*spd.travellerNumber*s.discount),
	SUM(s.spotPrice*spd.travellerNumber*(1-s.discount))
	FROM spot s
	INNER JOIN SpotBookingDetails spd ON spd.spotId=s.spotId
	WHERE YEAR(bookingDate)=@Year AND DAY(bookingDate)=@Day
	GROUP BY s.spotName
	RETURN
END
GO
--=============================================End of SECTION 07====================================================--

/*SECTION 08: Created Trigger*/


--Created a For trigger to restrict update and delete
CREATE TRIGGER trDeleteUpdate
On client
FOR UPDATE,DELETE
AS
BEGIN
	PRINT 'No Update Or Delete Possible'
	ROLLBACK TRANSACTION
END
GO


--Created table for making Trigger
--For trigger for Insert

CREATE Table product1
(
	pId INT PRIMARY KEY,
	pName VARCHAR(20),
	price Money,
	stock INT DEFAULT 0
)
GO

INSERT INTO product1 VALUES
(1,'Mouse',1200,0),
(2,'Key Board',1700,0),
(3,'Pen Drive',500,0)
GO

CREATE TABLE Instock1
(
	sId INT PRIMARY KEY,
	[date] DATETIME DEFAULT GETDATE(),
	pId INT REFERENCES product1(pId),
	quantity INT
)
GO

CREATE TABLE sales1
(
	id INT,
	[date] DATETIME,
	pId INT REFERENCES product1(pId),
	sale INT
)
GO

--(CReated Trigger to insert data in two or more  table at a time)
CREATE Trigger trStockIn2
ON Instock1
FOR INSERT
AS
BEGIN
	DECLARE @i INT
	DECLARE @q INT

	SELECT @i=pId,@q=quantity FROM inserted

	UPDATE product1 SET stock=stock+@q WHERE @i=pId
END
GO



--(CReated Trigger to insert data in two or more  table at a time)
CREATE Trigger trSales1
ON sales1
FOR INSERT
AS
BEGIN
	DECLARE @i INT
	DECLARE @s INT

	SELECT @i=pId,@s=sale FROM inserted

	UPDATE product1 SET stock=stock-@s WHERE @i=pId
END
GO



--Instead Of Trigger
--Created a Instead of TRIGGER ON TABLE agency
CREATE TRIGGER trRestrict
ON agency
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ag NVARCHAR(40)
	SELECT @ag=agencyName FROM inserted
	IF @ag<=1
	BEGIN
		INSERT INTO agency
		SELECT id,agencyid,agencyName,location FROM inserted
	END
	ELSE
	BEGIN
		RAISERROR ('You assigned a wrong type',10,1)
		ROLLBACK TRANSACTION
	END
END
GO
--=============================================End of SECTION 08====================================================--


/*SECTION 09: Created a TRANSACTION*/


-- Created A Transaction Name [transferPrice]
CREATE PROCEDURE spTransferPrice   @from INT,
								   @to INT,
								   @amount MONEY
AS
BEGIN TRY
	  BEGIN TRANSACTION
		UPDATE package
		SET packagePrice=packagePrice+@amount
		WHERE packageId=@to

		UPDATE package
		SET packagePrice=packagePrice-@amount
		WHERE packageId=@from
		COMMIT TRANSACTION
END TRY
BEGIN CATCH
		RAISERROR('Operation Failed!!!',10,1)
		ROLLBACK TRANSACTION
END CATCH
GO
--=============================================End of SECTION 09====================================================--




--=====================/////////////////////////End of DDL Script/////////////////////////////========================--