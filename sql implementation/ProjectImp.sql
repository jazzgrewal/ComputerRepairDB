-- ---------Create the Database----------
create database compRepair;
-- -----Select thet database for use-----
use compRepair;

-- ---------Create the tables------------
CREATE TABLE Customer (
    CustomerID INT(4) NOT NULL,
    GovernmentID CHAR(10) NOT NULL DEFAULT '',
    FirstName VARCHAR(15) NOT NULL DEFAULT '',
    LastName VARCHAR(20)  DEFAULT '',
    StreetName VARCHAR(20) NOT NULL DEFAULT '',
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
    TotalCost DECIMAL,
    Priority CHAR(1) NOT NULL DEFAULT '',
    DateIn date,
    DateOut date,
    ProductID INT(8) NOT NULL,
    PRIMARY KEY(RepairID),
    FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE RepairEvent MODIFY TotalCost DECIMAL(5,2);



ALTER TABLE RepairEvent
DROP COLUMN Issues;





CREATE TABLE Bill (
    BillID INT(8) NOT NULL,
    CostOfRepairment DOUBLE,
	PriorityCharges DOUBLE,
    Tax DECIMAL,
    Total DECIMAL,
    RepairID INT(8) NOT NULL,
    PRIMARY KEY (BillID),
    FOREIGN KEY (RepairID)
        REFERENCES RepairEvent (RepairID)
        ON UPDATE CASCADE ON DELETE CASCADE
);
ALTER TABLE Bill MODIFY Total DECIMAL(5,2);
ALTER TABLE Bill MODIFY Tax DECIMAL(5,2);
ALTER TABLE Bill MODIFY PriorityCharges DECIMAL(5,2);
ALTER TABLE Bill MODIFY CostOfRepairment DECIMAL(5,2);

CREATE TABLE PaymentMethod (
    PayID INT(3) NOT NULL,
    Method VARCHAR(20) NOT NULL,
    PRIMARY KEY (PayID)
);

CREATE TABLE UseToPay (
    Amount DECIMAL NOT NULL,
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
ALTER TABLE UseToPay MODIFY Amount DECIMAL(5,2) NOT NULL;


CREATE TABLE Inventory (
    PartID INT(6) NOT NULL,
    PartName VARCHAR(50) NOT NULL,
    Cost DECIMAL,
    StockLevel INT DEFAULT 0,
    Make VARCHAR(20) NOT NULL DEFAULT ' ',
    Description VARCHAR(100) NOT NULL DEFAULT ' ',
    PRIMARY KEY(PartID)
);
ALTER TABLE Inventory MODIFY Cost DECIMAL(5,2) NOT NULL;



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
    StreetName VARCHAR(20) NOT NULL DEFAULT '',
    Province CHAR(2) NOT NULL DEFAULT '',
    City VARCHAR(10) NOT NULL,
    PostalCode CHAR(7) NOT NULL DEFAULT '',
    PRIMARY KEY (StaffID)    
);



CREATE TABLE WorksOn (
    StaffID INT(4) NOT NULL,
    RepairID INT(8) NOT NULL,
    HoursWorked DECIMAL NOT NULL,
    DateStarted date,
    DateEnded date,
    FOREIGN KEY (RepairID)
        REFERENCES RepairEvent (RepairID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (StaffID)
        REFERENCES Staff (StaffID)
        ON UPDATE CASCADE ON DELETE CASCADE    
);
ALTER TABLE WorksOn MODIFY HoursWorked DECIMAL(5,2) NOT NULL;


-- ---------Inserting the tables------------

INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1002','9945001803','Robert','Davis','Main St 3445','Vancouver','BC','1974/05/03','M','7783434367','7784546744','RobD@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1006','9945001805','Taj','Zaveri','Squeezepenny Rd 2333','Vancouver','BC','1972/06/06','F','6048563456','7783345989','ZS3002@hotmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1021','9947001803','James','Smith','Redwood St 3398','Metrotown','BC','1974/05/02','M','6043469356','','JamesS03@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1023','9956001844','James','Smith','Copper St 7854','Richmond','BC','1979/04/04','M','6045673256','','Jamesmith@gmail.com');
INSERT INTO Customer (CustomerID,GovernmentID,FirstName,LastName,StreetName,City,Province,DateOfBirth,Gender,Phone1,Phone2,Email) VALUES ('1024','9934001856','Thomas','Lewis','Third Rd 2321','Vancouver','BC','1989/09/09','M','6042342346','','tomLowis04@gmail.com');

 
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002005','MacBook Pro 2018','Laptop','Keyboard malfunction','1002');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002009','MacBook pro 2013','Laptop','Display disabled','1006');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002010','Dell Inspiron','Desktop','Power supply instability','1021');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002011','MacBook Pro 2016','Laptop','Keyboard disabled','1021');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002012','Acer Aspire','Desktop','Damaged CPU','1023');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002014','MacBook Pro 2016','Laptop','Keyboard disable','1024');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002006','Hp Pavilion 2018','Laptop','Screen hazing','1002');
INSERT INTO Product (ProductID,ProductName,ProductType,Description,CustomerID) VALUES ('10002007',' Hp Slimline','Laptop','Ram Upgrade','1002');

 
 
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003035','Replaced with Pentium Gold G5400','130.78','N','2018/07/10','2018/10/25','10002012');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003036','Port got warmed out, fixed after replug','87.78','N','2018/08/07','2018/09/24','10002009');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003037','Replaced with SF Series SF450 Modular SFX','140.55','N','2018/07/10','2018/10/25','10002010');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003038','Water damage, completely replaced the keyboard','80.05','N','2018/03/27','2018/04/04','10002011');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003040','Control chip burned out, completely replaced the keyboard','90.96','N','2018/08/31','2018/08/05','10002014');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003033','Screen had to be replaced','80.05','Y','2018/02/26','2018/03/04','10002006');
INSERT INTO RepairEvent (RepairID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID) VALUES ('10003034','New ram 16gb installed','40.99','Y','2018/08/31','2018/08/31','10002007');

 
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001001','130.78','0','10.46','300','10003032');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001002','130.78','0','10.46','200','10003035');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001003','87.78','0','7.02','150','10003036');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001005','90.96','0','7.28','100','10003040');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001006','200.30','0','16.02','200','10003038');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001007','220.60','0','17.65','100','10003037');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001004','60.98','30','7.65','98.63','10003033');
INSERT INTO Bill (BillID,CostOfRepairment,PriorityCharges,Tax,Total,RepairID) VALUES ('10001008','94.99','30','9.65','134.64','10003034');


INSERT INTO PaymentMethod (PayID,Method) VALUES ('101','Debit Card');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('102','Credit Card');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('103','American Express');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('104','Cash');
INSERT INTO PaymentMethod (PayID,Method) VALUES ('105','Gift Card');

INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('150','1','10001001','101');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('150','2','10001001','102');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('200','1','10001002','103');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('180','1','10001003','104');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('100','1','10001005','105');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('200','1','10001006','103');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('220','1','10001007','101');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('45.00','1','10001004','101'); INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('45.00','2','10001004','103'); INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('8.63','3','10001004','104');

INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('50.00','1','10001008','105');
INSERT INTO UseToPay (Amount,NumberPayment,BillID,PayID) VALUES ('44.99','2','10001008','101');





INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300001','Fuse (Apple)','10','45','IBM','A type of fuse commonly used by Apple product');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300103','Pentium Gold G5400','89.99','2','INTEL','Common low power consumption CPU from intel');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300104','ISUN 8827mAh','23.99','2','AsRock','Third-party battery for iPad 5th gen and air');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300106','MacBook keyboards 2016','69.99','6','Intel','MacBook keyboard for 2016 and 2018 lineup');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300108','545s Series M.2 2280','89.99','3','AMD','256 GB M.2 SSD from intel');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300111','SF Series SF450 Modular SFX','114.99','1','Gigabyte','450W power supply from Corsair');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300002',' HP PAVILION 15-AB020CA','54.99','2','HP',' Touch Screen for Laptop Pavilion series');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300005',' HP PAVILION 15-AB020CA mount','5.99','4','HP',' Lcd Mounting Chip');
INSERT INTO Inventory (PartID,PartName,Cost,StockLevel,Make,Description) VALUES ('300007',' Kingston 16GB DDR4','94.99','20','Kingston',' 16GB Ram');


INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003035','300103','30010301');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003037','300111','30011101');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003038','300106','30010603');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003036','300001','30000101');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003040','300106','30010604');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003033','300002','30010401');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003033','300005','30010402');
INSERT INTO Uses (RepairID,PartID,SerialNumber) VALUES ('10003034','300007','30010403');


INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9002','9987001609','Jack Blanco','7784539806','Null','jazz@gmail.com','ErinSt7077','BC','Burnaby','J3B4K5');
INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9003','9987001609','Jacob Bean','7786432232','Null','JB009@gmail.com','BlissSt4638','BC','Port Coquitlam','N9G5H7');
INSERT INTO Staff (StaffID,GovernmentID,StaffName,Phone1,Phone2,Email,StreetName,Province,City,PostalCode) VALUES ('9004','9987001609','Jerry Brandon','7784323232','Null','JB00a@gmail.com','MiltonSt4973','BC','Surrey','L9N4N4');


INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003035','3','2018/04/12','2018/11/20');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003036','4','2018/09/03','2018/10/18');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003037','3','2018/04/12','2018/11/20');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003038','2','2018/05/28','2018/09/20');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9004','10003040','3','2018/04/07','2018/11/10');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9002','10003033','3','2018/04/11','2018/04/11');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003033','4','2018/04/12','2018/04/12');
INSERT INTO WorksOn (StaffID,RepairID,HoursWorked,DateStarted,DateEnded) VALUES ('9003','10003034','0.25','2018/08/31','2018/08/31');

SELECT * FROM Customer
CROSS Join Product WHERE Customer.LastName='Davis' and Customer.CustomerID=Product.CustomerId;

SELECT FirstName FROM Customer WHERE (Select Count(*) From Customer C,Product P Where C.CustomerId=P.CustomerID ) ;
Select Count(C.CustomerId) From Customer C,Product P Where C.CustomerId=P.CustomerId;
SELECT C.CustomerId,FirstName,ProductName FROM Customer C,Product P WHERE C.LastName='Davis' and C.CustomerID=P.CustomerId;


SELECT C.CustomerId,FirstName,LastName,StreetName,City,Province,Phone1,Email,ProductName FROM Customer C,Product P Where City='Vancouver' and C.CustomerId=P.CustomerId ;

SELECT  *  FROM Customer C,Product P  Where City='Vancouver' and C.CustomerId=P.CustomerId ;
SELECT  ProductId  FROM Customer C,Product P  Where City='Vancouver' and C.CustomerId=P.CustomerId ;

Select * FROM RepairEvent R,Bill B Where R.RepairID=B.RepairID ORDER BY B.CostOfRepairment ;
Select ProductId FROM RepairEvent R,Bill B Where R.RepairID=B.RepairID ORDER BY B.CostOfRepairment ;
/*finally query 2*/
Select  CustomerID,FirstName,LastName,StreetName,City,Province,Phone1,ProductName,CostOfRepairment
	From
    (SELECT  ProductId,C.CustomerId,FirstName,LastName,StreetName,City,Province,Phone1,ProductName  FROM Customer C,Product P  Where City='Vancouver' and C.CustomerId=P.CustomerId )A,
    (Select ProductId,CostOfRepairment FROM RepairEvent R,Bill B Where R.RepairID=B.RepairID)F
        where
        A.ProductID=F.ProductID
        ORDER BY CostOfRepairment ;
/*finally query 2*/
/*List all the bill that uses credit*/
Select * From PaymentMethod,UseToPay where Method='Credit Card';  
Select Method,NumberPayment,Amount From PaymentMethod,UseToPay where Method='Credit Card'; 
/*List the Bills For All the RepairID*/
Select * From RepairEvent R,Bill B where R.RepairID=B.RepairID;
Select BillID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID From RepairEvent R,Bill B where R.RepairID=B.RepairID; 
/*List All the Products of the Custiomer*/
Select * From Product P,Customer C where P.CustomerID=C.CustomerID ;   
Select FirstName,LastName,ProductName,ProductID From Product P,Customer C where P.CustomerID=C.CustomerID ; 
/*List all the Bill with the cutomer info*/
Select * From
(Select BillID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID From RepairEvent R,Bill B where R.RepairID=B.RepairID)A,
(Select FirstName,LastName,ProductName,ProductID From Product P,Customer C where P.CustomerID=C.CustomerID)B
Where
A.ProductID=B.ProductID;
/*query 3*/
Select * 
	From
    (Select BillID,Amount,Method,NumberPayment From PaymentMethod,UseToPay where Method='Credit Card')A,
    (Select FirstName,LastName,DamageDescription,TotalCost,BillID From
	(Select BillID,DamageDescription,TotalCost,Priority,DateIN,DateOut,ProductID From RepairEvent R,Bill B where R.RepairID=B.RepairID)A,
		(Select FirstName,LastName,ProductName,ProductID From Product P,Customer C where P.CustomerID=C.CustomerID)B
		Where
		A.ProductID=B.ProductID)B
    Where
    A.BillID=B.BillID
    group by A.BillID;
/*query 3*/

/*query 4*/
Select * From Product Where ProductType='Laptop';
/*list repair id whose type is laptop*/
Select * From RepairEvent R,Product P Where R.ProductID=P.ProductID and ProductType='Laptop';
Select RepairID From RepairEvent R,Product P Where R.ProductID=P.ProductID and ProductType='Laptop';
Select * From Uses U,RepairEvent R Where U.RepairID=R.RepairID;
/*list all the part using the repair id*/
Select * From
	Inventory I,
    (Select PartID,U.RepairID From Uses U,RepairEvent R Where U.RepairID=R.RepairID) J
    WHERE
    I.PartID=J.PartID;
    
/*query 4 strt*/
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
    /*query 4 end*/
    
    /*query 5*/
    Select * From Bill;
    
    Select * From RepairEvent Where DateIn BETWEEN CAST('2018-07-01' AS DATE) AND CAST('2018-07-28' AS DATE);
    
    Select * From RepairEvent R, Product P Where R.ProductID=P.ProductID;
    /*List all the Product with thier Bill Total*/
    Select A.RepairID,DateIn,ProductName,CustomerID,Total From
		(Select Total,RepairID From Bill)A,
        (Select RepairID,DateIN,ProductName,CustomerID From RepairEvent R, Product P Where R.ProductID=P.ProductID)B
        Where
        A.RepairID=B.RepairID;
    
    /*List all the RepaiID with the product name and customer NAme*/
    Select A.CustomerID,FirstName,LastName,RepairID,DateIN,ProductName,Total From 
		Customer A,
        (Select A.RepairID,DateIn,ProductName,CustomerID,Total From
				(Select Total,RepairID From Bill)A,
				(Select RepairID,DateIN,ProductName,CustomerID From RepairEvent R, Product P Where R.ProductID=P.ProductID)B
				Where
				A.RepairID=B.RepairID)B
        Where
        A.CustomerID=B.CustomerID;
    /*Now list all the RepairID between dates including the customer name and product name*/
      /*Now list all the Products Which CheckedIN the Store Between A Specific Date Including The Customer Name and City*/
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
        DateIn BETWEEN CAST('2018-01-01' AS DATE) AND CAST('2018-07-28' AS DATE);
	
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
        DateIn BETWEEN CAST('2018-07-01' AS DATE) AND CAST('2018-07-28' AS DATE);
        
    
    
    
    /*query 5*/
    
    
    
		



SELECT Count(*) FROM Customer C,Product P WHERE C.LastName='Davis' and C.CustomerID=P.CustomerId;

Select * From Customer C , Product P Where C.CustomerID=P.CustomerID and Count(C.CustomerID)=3;

 
 



SELECT * FROM PaymentMethod;
Select * from Customer;
Select * from Product;
Select * from Bill;
Select * from Inventory;
Select * from RepairEvent;
Select * from Staff;
Select * from Uses;
Select * from UseToPay;
Select * from WorksOn;
show tables;



