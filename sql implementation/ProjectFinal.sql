-- ---------Create the Database----------
create database compRepairFinal;
-- -----Select thet database for use-----
use compRepairFinal;
-- ---------Create the tables------------
CREATE TABLE Customer (
    CustomerID INT(4) NOT NULL,
    GovernmentID CHAR(10) NOT NULL DEFAULT '',
    FirstName VARCHAR(15) NOT NULL DEFAULT '',
    LastName VARCHAR(20)  DEFAULT '',
    StreetName VARCHAR(50) NOT NULL DEFAULT '',
    City VARCHAR(10) NOT NULL DEFAULT '',
    Province CHAR(2) NOT NULL DEFAULT '',
    PostalCode CHAR(7) NOT NULL DEFAULT '',
    DateOfBirth date,
    Gender CHAR(1) NOT NULL DEFAULT '',
    Phone1 CHAR(10) NOT NULL,
    Phone2 CHAR(10) ,
    Email VARCHAR(20) NOT NULL DEFAULT '',
    PRIMARY KEY (CustomerID)
);



CREATE TABLE Product (
    ProductID INT(8) NOT NULL,
    ProductName VARCHAR(25) NOT NULL DEFAULT '',
    ProductType VARCHAR(20) NOT NULL DEFAULT '',
    Description CHAR(35) NOT NULL DEFAULT '',
    CustomerID INT(4) NOT NULL,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE RepairEvent (
    RepairID INT(8) NOT NULL,
    Issues VARCHAR(40) NOT NULL DEFAULT '',
    DamageDescription VARCHAR(100) NOT NULL DEFAULT '',
    Priority CHAR(1) NOT NULL DEFAULT '',
    DateIn date,
    DateOut date,
    ProductID INT(8) NOT NULL,
    PRIMARY KEY(RepairID),
    FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Bill (
    BillID INT(8) NOT NULL,
    CostOfRepairment DOUBLE(5,2)NOT NULL,
	PriorityCharges DOUBLE(5,2)NOT NULL,
    Tax DECIMAL(5,2)NOT NULL,
    Total DECIMAL(5,2)NOT NULL,
    RepairID INT(8) NOT NULL,
    PRIMARY KEY (BillID),
    FOREIGN KEY (RepairID)
        REFERENCES RepairEvent (RepairID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE PaymentMethod (
    PayID INT(3) NOT NULL,
    Method VARCHAR(20) NOT NULL,
    PRIMARY KEY (PayID)
);

CREATE TABLE UseToPay (
    Amount DECIMAL(5,2) NOT NULL,
    NumberPayment INT NOT NULL,
    BillID INT(8) NOT NULL,
    PayID INT(3) NOT NULL,
    FOREIGN KEY (BillID)
        REFERENCES Bill (BillID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (PayID)
        REFERENCES PaymentMethod (PayID)
        ON UPDATE CASCADE ON DELETE CASCADE    
);

CREATE TABLE Inventory (
    PartID INT(6) NOT NULL,
    PartName VARCHAR(50) NOT NULL,
    Cost DECIMAL(5,2) NOT NULL,
    StockLevel INT DEFAULT 0,
    Make VARCHAR(20) NOT NULL DEFAULT ' ',
    Description VARCHAR(100) NOT NULL DEFAULT ' ',
    PRIMARY KEY(PartID)
);

CREATE TABLE Uses (
    RepairID INT(8) NOT NULL,
    PartID INT(6) NOT NULL,
    SerialNumber CHAR(8) NOT NULL,
    PRIMARY KEY(SerialNumber),
    FOREIGN KEY (RepairID)
        REFERENCES RepairEvent (RepairID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (PartID)
        REFERENCES Inventory (PartID)
        ON UPDATE CASCADE ON DELETE CASCADE    
);

CREATE TABLE Staff (
    StaffID INT(4) NOT NULL,
    GovernmentID CHAR(10) NOT NULL,
	StaffName VARCHAR(15) NOT NULL DEFAULT '',
    Phone1 CHAR(10) NOT NULL,
    Phone2 CHAR(10) ,
    Email VARCHAR(20) NOT NULL DEFAULT '',
    StreetName VARCHAR(50) NOT NULL DEFAULT '',
    Province CHAR(2) NOT NULL DEFAULT '',
    City VARCHAR(30) NOT NULL,
    PostalCode CHAR(7) NOT NULL DEFAULT '',
    PRIMARY KEY (StaffID)    
);


CREATE TABLE WorksOn (
    StaffID INT(4) NOT NULL,
    RepairID INT(8) NOT NULL,
    HoursWorked DECIMAL(5,2) NOT NULL,
    DateStarted date,
    DateEnded date,
    FOREIGN KEY (RepairID)
        REFERENCES RepairEvent (RepairID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID)
        REFERENCES Staff (StaffID)
        ON UPDATE CASCADE ON DELETE CASCADE    
);

-- ---------Inserting the tables------------
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1002','9945001803','Robert','Davis','Main St 3445','Vancouver','BC','1974/05/03','M','7783434367','7784546744','RobD@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1006','9945001805','Taj','Zaveri','Squeeze penny Rd 2333','Vancouver','BC','1972/06/06','F','6048563456','7783345989','ZS3002@hotmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1021','9947001803','James','Smith','Redwood St 3398','Metrotown','BC','1974/05/02','M','6043469356','','JamesS03@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1023','9956001844','James','Smith','Copper St 7854','Richmond','BC','1979/04/04','M','6045673256','','Jamesmith@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1024','9934001856','Thomas','Lewis','Third Rd 2321','Vancouver','BC','1989/09/09','M','6042342346','','tomLowis04@gmail.com');

INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002005','MacBook Pro 2018','Laptop','Keyboard malfunction','1002');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002006','Hp Pavilion 2018','Laptop','Screen hazing','1002');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002007','Hp Slimline','Laptop','Ram Upgradation','1002');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002009','MacBook pro 2013','Laptop','Display disabled','1006');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002010','Dell Inspiron','Desktop','Power supply instability','1021');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002011','MacBook Pro 2016','Laptop','Keyboard disabled','1021');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002012','Acer Aspire','Desktop','Damaged CPU','1023');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002014','MacBook Pro 2016','Laptop','Keyboard disabled','1024');


INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003032','Dust damage few nods, completely replaced the keyboard','N','2019-03-09','2019-03-14','10002005');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003035','Replaced with Pentium Gold G5400','N','2019-03-09','2019-03-13','10002012');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003033','Screen had to be replaced','Y','2019-01-01','2019-01-03','10002006');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003034','New ram 16gb installed','Y','2019-03-30','2019-04-01','10002007');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003036','Port got warmed out, fixed after replug','N','2019-02-28','2019-03-05','10002009');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003037','Replaced with SF Series SF450 Modular SFX','N','2019-03-10','2019-03-14','10002010');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003038','Water damage, completely replaced the keyboard','N','2019-02-26','2019-03-03','10002011');
INSERT INTO RepairEvent (RepairID,DamageDescription,Priority,DateIN,DateOut,ProductID) VALUES ('10003040','Control chip burned out, completely replaced the keyboard','N','2019-01-07','2019-01-10','10002014');


INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001001','70.00','0.00','8.40','78.40','10003032 ');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001002','90.00','0.00','10.80','100.80','10003035');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001003','10.00','0.00','1.20','10.20','10003036');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001004','60.98','30.00','10.92','101.90','10003033');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001005','90.00','0.00','10.80','98.40','10003040');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001006','70.00','0.00','8.40','78.40','10003038');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001007','90','0.00','10.80','100.80','10003037');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001008','94.99','30.00','15.00','140.00','10003034');


INSERT INTO PaymentMethod (PayID,Method) VALUES ('101','Debit Card');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('102','Credit Card');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('103','American Express');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('104','Cash');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('105','Gift Card');


INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('50.00','1','10001001','101');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('28.40','2','10001001','102');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('100.80','1','10001002','103');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('10.20','1','10001003','104');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('101.90','1','10001004','105');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('98.40','1','10001005','103');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('78.40','1','10001006','101');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('50.00','1','10001007','104');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('50.80','2','10001007','102');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('140.00','1','10001008','101');



INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300001','Fuse (Apple)','10.00','45','IBM','A type of fuse commonly used by Apple product');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300002','HP PAVILION 15-AB020CA','54.99','2','HP','Touch Screen for Laptop Pavilion series');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300005','HP PAVILION 15-AB020CA mount','5.99','4','HP','LCD Mounting Chip');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300007','Kingston 16GB DDR4','94.99','20','Kingston','16GB Ram');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300103','Pentium Gold G5400','90.00','2','INTEL','Common low power consumption CPU from intel');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300104','ISUN 8827mAh','24.00','2','As Rock','Third-party battery for iPad 5th gen and air');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300106','MacBook keyboards 2016','70.00','6','Intel','MacBook keyboard for 2016 and 2018 lineup');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300108','545s Series M.2 2280','90.00','3','AMD','256 GB M.2 SSD from intel');


INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003036','300001','30000201');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003035','300103','30010301');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003033','300002','30010401');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003033','300005','30010402');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003034','300007','30010403');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003038','300106','30010603');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003040','300106','30010604');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003037','300104','30011101');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003032','300106','30112345');


INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9002','9987001609','Jack Blanco','7784539806','Null','jazz@gmail.com','ErinSt7077','BC','Burnaby','J3B4K5');
INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9003','9987001609','Jacob Bean','7786432232','Null','JB009@gmail.com','BlissSt4638','BC','Port Coquitlam','N9G5H7');
INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9004','9987001609','Jerry Brandon','7784323232','Null','JB00a@gmail.com','MiltonSt4973','BC','Surrey','L9N4N4');


INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003032 ','3.00','2019-03-12','2019-03-12');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003036','4.00','2019-03-03','2019-03-03');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003037 ','3.00','2019-03-12','2019-03-12');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003038 ','2.00','2019-02-28','2019-02-28');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9004','10003040 ','3.00','2019-01-07','2019-01-08');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003033 ','3.00','2019-01-02','2019-01-02');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003033 ','4.00','2019-01-03','2019-01-03');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003034 ','1.00','2019-03-31','2019-03-31');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003035 ','3.00','2019-03-13','2019-03-13');

/*Query 1 -List all the Customers who lived in Vancouver and their detailed address info,phone and all the products they have, based on the CostOfRepair*/
Select  CustomerID,FirstName,LastName,StreetName,City,Province,Phone1,ProductName,CostOfRepairment
	From
    (SELECT  ProductId,C.CustomerId,FirstName,LastName,StreetName,City,Province,Phone1,ProductName  FROM Customer C,Product P  Where City='Vancouver' and C.CustomerId=P.CustomerId )A,
    (Select ProductId,CostOfRepairment FROM RepairEvent R,Bill B Where R.RepairID=B.RepairID)F
        where
        A.ProductID=F.ProductID
        ORDER BY CostOfRepairment ;
/*Query 1*/

/*query 2-List all the Transactions where credit card was used including the Customer Name who Paid the amount and what was the total of that Bill,Including the Name of Product for which the Payment was made and damage description*/
Select A.BillID,Amount,Method,FirstName,LastName,ProductName,DamageDescription,Total 
	From
    (Select BillID,Amount,Method,NumberPayment From PaymentMethod,UseToPay where Method='Credit Card')A,
    (Select FirstName,LastName,DamageDescription,BillID,Total,ProductName From
	(Select BillID,DamageDescription,Priority,DateIN,DateOut,ProductID,B.Total From RepairEvent R,Bill B where R.RepairID=B.RepairID)A,
		(Select FirstName,LastName,ProductName,ProductID From Product P,Customer C where P.CustomerID=C.CustomerID)B
		Where
		A.ProductID=B.ProductID)B
    Where
    A.BillID=B.BillID
    GROUP BY A.BillID;
/*query 2*/

/*query 3 strt-List all the Laptops(with Product details) including the Damage Description and the Parts Used for its Repairment with the Cost of each Part*/
Select A.RepairID,ProductID,ProductName,ProductType,Description,PartName,Cost
	From
		(Select RepairID,R.ProductID,ProductName,ProductType,Description From RepairEvent R,Product P Where R.ProductID=P.ProductID and ProductType='Laptop')A,
		(Select PartName,Cost,RepairID From
			Inventory I,
			(Select PartID,U.RepairID From Uses U,RepairEvent R Where U.RepairID=R.RepairID) J
			WHERE
			I.PartID=J.PartID)B
	Where
    A.RepairID=B.RepairID;
    /*query 3 end*/
    
          /*Query4-Now list all the Products Which CheckedIN the Store Between A Specific Date Including The Customer Name and City*/
    Select * 
    From
		(Select A.CustomerID,FirstName,LastName,City,RepairID,DateIN,ProductName,Total From 
			Customer A,
			(Select A.RepairID,DateIn,ProductName,CustomerID,Total From
					(Select Total,RepairID From Bill)A,
					(Select RepairID,DateIN,ProductName,CustomerID From RepairEvent R, Product P Where R.ProductID=P.ProductID)B
					Where
					A.RepairID=B.RepairID)B
			Where
			A.CustomerID=B.CustomerID)A
        Where
        DateIn BETWEEN CAST('2019-03-01' AS DATE) AND CAST('2019-03-28' AS DATE);
        /*Query4 ends*/
        
         /*query total income of the store between two dates*/
    Select SUM(Total) AS myTotal
    From
		(Select A.CustomerID,FirstName,LastName,RepairID,DateIN,ProductName,Total From 
			Customer A,
			(Select A.RepairID,DateIn,ProductName,CustomerID,Total From
					(Select Total,RepairID From Bill)A,
					(Select RepairID,DateIN,ProductName,CustomerID From RepairEvent R, Product P Where R.ProductID=P.ProductID)B
					Where
					A.RepairID=B.RepairID)B
			Where
			A.CustomerID=B.CustomerID)A
        Where
        DateIn BETWEEN CAST('2019-01-01' AS DATE) AND CAST('2019-01-28' AS DATE);
        
    

