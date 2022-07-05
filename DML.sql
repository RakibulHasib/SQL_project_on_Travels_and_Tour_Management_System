/*				SQL Project Name : Travels and Tours Management System in Bangladesh
							    Trainee Name : Rakibul Hasib  
						    	  Trainee ID : 1269816      
								    Batch ID : ESAD-CS/PNTL-A/51/01 
--======================================================================================================--*/

--========Contents: DML=======--
/*
    => SECTION 01: INSERTING DATA INTO TABLE
    => SECTION 02: TEST (View, Trigger, Function, Transaction)
    => SECTION 03: All Type of Join
    => SECTION 04: Query to retrieve data from database  with aggregate function
	=> SECTION 05: CASE,CTE,Grouping Sets,Rollup,Cube,Cast,Convert,If Else,loop,Try Catch,GOTO,Waitfor,Like and Between operator
	=> SECTION 06: Some usage of Built_in_Function
*/


--=====================================   START OF DML SCRIPT   =======================================--

/*=> SECTION 01: INSERTING DATA INTO TABLE*/

--01 Inserted data into tbl(agency) by sequence

INSERT INTO dbo.agency VALUES
(NEXT VALUE FOR [DBO].[Sequence],DEFAULT,'Unique Travel and tour management','Dhaka')
GO
SELECT * FROM agency
GO

--02 Inserted data into tbl(client) in normal way 

INSERT INTO client VALUES
('Rakibul Hasib',01646053194,'Shekertek,Mohammadpur','Dhaka','Male','1997222832273','rakimhasib786@gmail.com'),
('Nazia Nur',01643433909,'Green Road,Firmgate','Dhaka','Female','1985228329475','nazia383@gmail.com'),
('Mifatahul Jannat',01706896297,'Ramnagar,Dagonbhuiyan','Feni','Female','1977598394478','miftahul094@gmail.com'),
('Barat Al Din',01946053192,'College gate,Chowmuhani','Noakhali','Male','1987298322493','barat@gmail.com'),
('Aydan Adenin',01546053195,'Gudaragat,Mirpur','Dhaka','Male','1999228333756','aydan888@gmail.com'),
('Habib Rahman',01446053199,'Azampur,Uttara','Dhaka','Male','1985258758377','habib092@gmail.com'),
('Faiza Rahman',01346053198,'Adabor,Mohammadpur','Dhaka','Female','1972492888312','faiza046@gmail.com'),
('Shams Ark',01846053144,'Tigerpass','CTG','Male','1987983248312','shams029@gmail.com'),
('Lamina Afrin',01746053122,'Townhall,Mohammadpur','Dhaka','Female','1992298128393','lamina787@gmail.com'),
('Sohidul Islam',01646053333,'Moynamati','Comilla','Male','1975296218373','sohidul546@gmail.com')
GO
SELECT * FROM client
GO

--03 Inserted data into tbl(spot) in normal way 

INSERT INTO spot VALUES
('Saint Martin','Coxs Bazar',4,'06-07-2022','06-10-2022',20000.00,0.15,1),
('Sajek','Khagrachodi',3,'06-15-2022','06-17-2022',15000.00,0.05,1),
('Nilgiri','Bandarban',3,'06-20-2022','06-22-2022',12000.00,0,1),
('Bichanakandi','Coxs Bazar',2,'06-12-2022','06-14-2022',10000.00,0.10,0),
('Sundorbon','Khulna',3,'06-25-2022','06-27-2022',20000.00,0.10,1),
('Nijum Dip','Noakhali',3,'06-28-2022','06-30-2022',18000.00,0,1)
GO
SELECT * FROM spot
GO

--04 Inserted data into tbl(package) in normal way 
INSERT INTO package VALUES
('Saint Martin/Inani/Himchodi','Coxs Bazar',4,'06-07-2022','06-10-2022',30000.00,0.05,1),
('Nilgiri/Nilachol/Debotakhum','Bandorbon',4,'06-15-2022','06-18-2022',28000.00,0,1),
('Japlong/Srimongol/Bichanakandi','Sylhet',3,'06-16-2022','06-18-2022',25000.00,0.01,1),
('Sundorbon/Shat Gombuj Mosjid','Khulna',2,'06-07-2022','06-09-2022',20000.00,0.05,1),
('Nijum Dip/Sorno Dip/Musapur closer','Noakhali',3,'06-07-2022','06-10-2022',35000.00,0.05,0),
('Jhulonto Bridge/Kaptai Lake/Rubber Forest','Rangamati',3,'06-20-2022','06-22-2022',25000.00,0.05,1)
GO
SELECT * FROM package
GO

--05 Inserting Data into tbl(hotel) Using store Procedure

EXEC spInsertHotel 'Sea Gal Hotel'
EXEC spInsertHotel 'Chul Jal Hotel'
EXEC spInsertHotel 'Sky View Hotel'
EXEC spInsertHotel 'Grand Hotel'
EXEC spInsertHotel 'Rajmahal Hotel'
EXEC spInsertHotel 'Royal Tulip Hotel'
EXEC spInsertHotel 'Exclusive Hotel'
GO
SELECT * FROM hotel
GO

--06 Inserting data into tbl(transportation) with view

INSERT INTO v_transportation VALUES
('Bus'),
('Train'),
('Aeroplane'),
('Ship'),
('Private Hiace')
GO
SELECT * FROM transportation

--07 Inserted data into tbl(SpotBookingDetails) in normal way 

INSERT INTO SpotBookingDetails VALUES
(1,1,3,3,1,'06-05-2022',12000.00,4,0.10),
(1,3,6,5,4,'06-26-2022',18000.00,5,0.10),
(1,9,2,4,1,'06-13-2022',15000.00,3,0.05),
(1,7,1,6,3,'06-05-2022',20000.00,10,0.15),
(1,5,5,2,5,'06-22-2022',20000.00,6,0.10)
GO
SELECT * FROM SpotBookingDetails

--08 Inserted data into tbl(packageBookingDetails) in normal way 

INSERT INTO packageBookingDetails VALUES
(1,2,1,6,3,'06-05-2022',30000.00,5,0.05),
(1,4,2,3,1,'06-12-2022',28000.00,8,0),
(1,6,3,4,2,'06-03-2022',25000.00,7,0.01),
(1,8,4,2,5,'06-01-2022',20000.00,15,0.05),
(1,10,6,6,1,'06-15-2022',25000.00,6,0.05)
GO 
SELECT * FROM packageBookingDetails
GO
--=============================================End of SECTION 01====================================================--


/*SECTION 02: TEST (View, Trigger, Function, Transaction)*/

--Test View

--01(Viewing client Information through vClientInformation)
EXEC sp_helptext 'vClientInformation'
GO

--02(Viewing all spot and package name through vAllSpotAndPackageName)
EXEC sp_helptext 'vAllSpotAndPackageName'
GO


--Test Stotre procedure

--01(Created store procedure to see all transportation Information )
EXEC spTransportationAll
GO

--02(Created store procedure to see which packages are available)
EXEC spPackageAvailable
GO

--03(Created store procedure to see client information through city)
EXEC spClientCity 'Dhaka'
GO

--04(Created a store procedure on testIndex to insert data with return)
DECLARE @id INT
EXEC @id=spTestIndexInsertWithReturn 1,'Rakim'
PRINT 'Neww Id inserted With Id:'+STR(@id)
GO

--05(Created a store procedure on testIndex to insert data with default values)
EXEC spTestIndexInsertWithDefaultvalues @id=1
GO

--06(Created a store procedure Passing Output Parameters)
DECLARE @Id INT
EXEC spTestIndexInsertWithReturn02 3,'Azman',@Id OUTPUT
SELECT @Id 'New Id'
GO

--Test UDF

--01(Created a function to calculate total discount for a spot)
--scalar valued function
SELECT dbo.fnSpotdiscont(60,6,0.05) 'Total Discount'
Go

--02(Created a function to calculate (total price,discount,net price))
--single table valued function
SELECT * FROM dbo.fnAllSummary(2022,06)
GO

--03(Created a function to calculate (total price,discount,net price)) 
--Using multi statement table valued function
SELECT * FROM dbo.fPriceDetails (2022,05)
GO


--Test Trigger
--01(For Trigger for DELETE and UPDATE)
--test update
UPDATE client SET clientName='Rohim' WHERE clientId=1
GO
--test delete
DELETE FROM client WHERE clientId=3
GO

----01(CReated Trigger to insert data in two or more  table at a time)
INSERT INTO Instock1 VALUES
(3,'2022-03-04',3,70)
GO
INSERT INTO sales1 VALUES
(2,'2022-07-07',3,20)
GO
--test
SELECT * FROM product1
SELECT * FROM Instock1
SELECT * FROM sales1
GO



--02(Created instead of trigger on agency table)
--Test
INSERT INTO agency VALUES(2,DEFAULT,95456,'CTG')
GO


--Transaction
--(Created a transaction for transfer price on package table)
EXEC spTransferPrice 6,1,5000
GO
--=============================================End of SECTION 02====================================================--

/* SECTION 03: All type of join*/

--Inner join
SELECT p.packageId,packageName,pbd.bookingDate,pbd.totalPrice FROM package p 
INNER JOIN packageBookingDetails pbd ON pbd.packageId=p.packageId
GO

--Left join
SELECT s.spotId,s.spotName,sbd.bookingDate,sbd.totalPrice FROM spot s
LEFT JOIN SpotBookingDetails sbd ON sbd.spotId=s.spotId
GO

--Right Join
SELECT p.packageId,packageName,pbd.bookingDate,pbd.totalPrice FROM package p 
Right JOIN packageBookingDetails pbd ON pbd.packageId=p.packageId
GO
--Full Join
SELECT s.spotId,s.spotName,sbd.bookingDate,sbd.totalPrice FROM spot s
Full JOIN SpotBookingDetails sbd ON sbd.spotId=s.spotId
GO


--CROSS Join
SELECT c.clientId,c.clientName,pbd.packagePrice,pbd.totalPrice FROM client c
CROSS JOIN packageBookingDetails pbd
GO
--=============================================End of SECTION 03====================================================--

/*SECTION 04: Query to retrieve data from database with aggregate function */

--01
Select c.clientId,clientName,s.spotName,SUM(s.spotPrice*sbd.travellerNumber*(1-s.discount)) AS 'Net Price' FROM client c
INNER JOIN SpotBookingDetails sbd ON sbd.clientId=c.clientId
INNER JOIN spot s ON s.spotId=sbd.spotId
WHERE c.clientId<=5
GROUP BY c.clientId,clientName,s.spotName
ORDER BY c.clientId
GO

--02
SELECT pbd.clientId,pbd.bookingId,h.hotelId,COUNT(h.hotelName) AS 'Count Hotel',pbd.totalPrice FROM hotel h
INNER JOIN packageBookingDetails pbd ON pbd.hotelId=h.hotelId
GROUP BY pbd.clientId,pbd.bookingId,h.hotelId,pbd.totalPrice
HAVING h.hotelId<5
ORDER BY pbd.clientId DESC
GO

--subquery
--01
SELECT c.clientId,c.City,c.address FROM (SELECT * FROM client) as c
GO
--02
SELECT clientId,clientName FROM client
WHERE clientId NOT IN (SELECT DISTINCT clientId FROM SpotBookingDetails)
GO

--Correlated subquery
--01
SELECT s.spotId,s.spotName,s.tourDuration FROM spot s
WHERE s.tourDuration=(SELECT MIN(o1.tourDuration) FROM spot o1 WHERE s.tourDuration=o1.tourDuration)
ORDER BY s.tourDuration
GO
--=============================================End of SECTION 04====================================================--

/*SECTION 05: CASE,CTE,Grouping Sets,Rollup,Cube,Cast,Convert,If Else,loop,Try Catch,GOTO,Waitfor,Like and Between operator*/

--Using CASE
SELECT hotelId,hotelName,
	CASE
		WHEN hotelId=1 THEN 'Five Star Hotel'
		WHEN hotelId=2 THEN 'Three Star Hotel'
		WHEN hotelId=3 THEN 'One Star Hotel'
		WHEN hotelId=4 THEN 'One Star Hotel'
		ELSE 'First Class Hotel'
	END AS status
FROM hotel
GO

--Using CTE
WITH myCTE AS
(
	Select c.clientId,clientName,s.spotName,SUM(s.spotPrice*sbd.travellerNumber*(1-s.discount)) AS 'Net Price' FROM client c
	INNER JOIN SpotBookingDetails sbd ON sbd.clientId=c.clientId
	INNER JOIN spot s ON s.spotId=sbd.spotId
	WHERE c.clientId<=5
	GROUP BY c.clientId,clientName,s.spotName
)
SELECT * FROM myCTE
GO

--Using(Grouping Sets,Rollup,Cube)

--Rollup
SELECT COALESCE(clientName,'ALL SUBJECT NUMBER') AS 'Client Name',
COUNT(clientId) AS TOTAL
FROM client
GROUP BY ROLLUP (clientName)
Go

--Cube
SELECT COALESCE(clientName,'ALL SUBJECT NUMBER') AS 'Client Name',
COUNT(clientId) AS TOTAL
FROM client
GROUP BY CUBE (clientName)
Go

--Grouping Sets
SELECT spotId,COALESCE(spotName,'All Spot Price') AS spotName,SUM(spotPrice) FROM spot
GROUP By GROUPING SETS(spotId,spotName,(spotId,spotName),())
GO


--Using Cast and Convert
--cast
SELECT CAST('01-june-2019 10:00 AM' AS DATE) AS 'date'

--convert
DECLARE @dateTime DATETIME
SET @dateTime='01-june-2019 10:00 AM'
SELECT CONVERT(varchar,@dateTime,8) AS 'time'


--Using IF ELSE
DECLARE @packagePrice MONEY
SET @packagePrice=35000

IF @packagePrice>30000
	PRINT 'Diamond Package'
ELSE
BEGIN
	IF @packagePrice>25000
	PRINT 'Golden Package'
ELSE
	PRINT 'Normal Package'
END
GO

--Using loop
declare @spotId INT=10
While @spotId>=1
	Begin
	Print @spotId
	IF @spotId=(5)
		BREAK
	Set @spotId=@spotId-1
	End
	GO

--Using Try Catch
Begin Try
	declare @val INT=1
While @val<=10
	Begin
	Print @val
	IF @val=(5)
		BREAK
	Set @val=@val/0
	End
End Try
Begin Catch
	PRINT 'Error'
End catch
GO

--Using GOTO
declare @spot MONEY
SET @spot=25000

If @spot>=25000
	GOTO Diamond
If @spot<20000
	GOTO Bronge
Diamond:
	PRINT 'This ia Diamond spot'
RETURN
Bronge:
	PRINT 'This is a Bronge spot'
RETURN
GO

--Using Waitfor
select GETDATE() CurrentDate
Waitfor delay '00:00:05'
select GETDATE() CurrentDate
GO

--Using Like Operator
SELECT * from client Where clientName LIKE 'A%'
SELECT * from client Where clientName LIKE '%A'
--Using Between and Operator
SELECT spotId,startingDate FROM spot 
WHERE startingDate Between '2022-06-07' AND '2022-06-12'
ORDER BY spotId DESC
GO
--=============================================End of SECTION 05====================================================--

/*SECTION 06: Some usage of Built_in_Function*/

--Using many type of Built in Function 
--01
SELECT STR(1)+STR(2) As 'total'

--02
DECLARE @b INT=90
SELECT 'I GOT'+STR(@b)

--03
SELECT RTRIM('RAKIm                              ')+' Hasib'

--04
SELECT SUBSTRING('Rakibul Hasib',1,8)

--05
select GETDATE() 'Today'

--06
SELECT YEAR(GETDATE()) 'Year'

--07
SELECT MONTH(GETDATE()) 'month'

--08
SELECT DAY(GETDATE()) 'Day'

--09
SELECT DATEDIFF (MONTH,'11-11-1984',GETDATE())

--10
SELECT DATEADD (MONTH,10,GETDATE())
GO
--=============================================End of SECTION 06====================================================--



--=====================/////////////////////////End of DML Script/////////////////////////////========================--