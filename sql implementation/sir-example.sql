-- ---------Create the Database----------
create database Sample2312;

-- -----Select thet database for use-----
use Sample2312;

-- ---------Create the tables------------
CREATE TABLE Branch (
    branchNo CHAR(4) NOT NULL,
    street VARCHAR(25) NOT NULL DEFAULT '',
    city VARCHAR(20) NOT NULL DEFAULT '',
    postcode CHAR(7) NOT NULL DEFAULT '',
    PRIMARY KEY (branchNo)
);

CREATE TABLE Staff (
    staffNo CHAR(4) NOT NULL,
    fName VARCHAR(50) NOT NULL DEFAULT '',
    lName VARCHAR(50) NOT NULL DEFAULT '',
    sPosition VARCHAR(15) NOT NULL DEFAULT '',
    sex CHAR(1),
    DOB DATE,
    salary INT,
    branchNo CHAR(4) NOT NULL,
    PRIMARY KEY (staffNo),
    FOREIGN KEY (branchNo)
        REFERENCES Branch (branchNo)
        ON UPDATE CASCADE ON DELETE CASCADE
);
 
-- -----Some useful commands about tables------
  SHOW tables;
 
  describe Branch;
  describe Staff;
 
  show create table Branch;
 
-- ------Continue creating the tables-------
CREATE TABLE PrivateOwner (
    ownerNo CHAR(4) NOT NULL,
    fName VARCHAR(50) NOT NULL DEFAULT '',
    lName VARCHAR(50) NOT NULL DEFAULT '',
--  address reformatted for consistency with other tables
    street VARCHAR(25) NOT NULL DEFAULT '',
    city VARCHAR(20) NOT NULL DEFAULT '',
    postcode CHAR(7) NOT NULL DEFAULT '',
--  Phone accepts only digits, two digits for country code
    telNo CHAR(14) NOT NULL,
    eMail VARCHAR(50) NOT NULL,
    -- password excluded
   PRIMARY KEY (ownerNo),
    INDEX (lName),
    INDEX (postcode)
);

CREATE TABLE PropertyForRent (
    propertyNo CHAR(4) NOT NULL,
    street VARCHAR(25) NOT NULL DEFAULT '',
    city VARCHAR(20) NOT NULL DEFAULT '',
    postcode CHAR(7) NOT NULL DEFAULT '',
    pType VARCHAR(18) NOT NULL DEFAULT ' ',
    rooms TINYINT UNSIGNED,
    rent SMALLINT UNSIGNED,
    ownerNo CHAR(4) NOT NULL,
    staffNo CHAR(4),
    branchNo CHAR(4) NOT NULL,
    PRIMARY KEY (propertyNo),
    FOREIGN KEY (ownerNo)
        REFERENCES PrivateOwner (ownerNo)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (staffNo)
        REFERENCES Staff (staffNo)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (branchNo)
        REFERENCES Branch (branchNo)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);    

CREATE TABLE CClient (
    clientNo CHAR(4) NOT NULL,
    fName VARCHAR(50) NOT NULL DEFAULT '',
    lName VARCHAR(50) NOT NULL DEFAULT '',
    telNo CHAR(14) NOT NULL,
    prefType VARCHAR(18) NOT NULL DEFAULT ' ',
    maxRent SMALLINT UNSIGNED,
    eMail VARCHAR(50) NOT NULL,
    PRIMARY KEY (clientNo),
    INDEX (lName)
);
 
CREATE TABLE Viewing (
    clientNo CHAR(4) NOT NULL,
    propertyNo CHAR(4) NOT NULL,
    viewDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    vComment MEDIUMTEXT,
    PRIMARY KEY (clientNo , propertyNo , viewDate),
    FOREIGN KEY (clientNo)
        REFERENCES CClient (clientNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (propertyNo)
        REFERENCES PropertyforRent (propertyNo)
        ON DELETE CASCADE ON UPDATE CASCADE
);  
 
CREATE TABLE Registration (
    clientNo CHAR(4) NOT NULL,
    branchNo CHAR(4),
    staffNo CHAR(4) ,
    dateJoined DATE NOT NULL,
    PRIMARY KEY (clientNo),
    FOREIGN KEY (clientNo)
        REFERENCES CClient (clientNo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (branchNo)
        REFERENCES Branch (branchNo)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (staffNo)
        REFERENCES Staff (staffNo)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
 
 show tables;
 
 -- ------------------Fill the Tables------------------
  insert into branch(branchNo,street,city,postcode)
  values ('B005', '22 Deer Rd'  ,'London'  , 'SW1 4EH'),
         ('B007', '16 Argyll St','Aberdeen', 'AB2 3SU'),
         ('B003', '163 Main St' ,'Glasgow' , 'G11 9QX'),
         ('B004', '32 Manse Rd' ,'Bristol' , 'BS9 1NZ'),
         ('B002', '56 Clover Dr','London'  , 'NW1 6EU');
 
  insert into privateOwner(ownerNo,fName    ,lName   ,street    ,city  ,postcode    ,telNo,     eMail)
  values            ('CO46', 'Joe'  ,'Keogh'  , '2 Fergus Dr','Aberdeen', 'AB2 7SX' , '01224-861212' , 'jkeogh@lhh.com'),
                    ('CO87', 'Carol','Farrel' , '6 Achray St','Glasgow' , 'G32 9DX' , '0141-357-7419', 'cfarrel@gmail.com'), 
                    ('CO40', 'Tina' ,'Murphy' , '63 Well St' ,'Glasgow' , 'G42'     , '0141-943-1728', 'tinam@hotmail.com'), 
                    ('CO93' ,'Tony' ,'Shaw'   , '12 Park Pl' ,'Glasgow' , 'G4 0QR'  , '0141-225-7025', 'tony.shaw@ark.com');

-- ----Test those tables----- 
  SELECT * FROM Branch;
  SELECT * FROM privateOwner;

-- ---------Continue fillling the Tables---------
  insert into Staff(staffNo,fName    ,lName   ,sPosition    ,sex,     DOB      ,salary, branchNo)
  values            ('SL21', 'John'  ,'White' , 'Manager'   ,'M', '1945-10-01' , 30000, 'B005'),
                    ('SG37', 'Ann'   ,'Beech' , 'Assistant' ,'F', '1960-11-10' , 12000, 'B003'), 
                    ('SG14', 'David' ,'Ford'  , 'Supervisor','M', '1958-03-24' , 18000, 'B003'), 
                    ('SA9' , 'Mary'  ,'Howe'  , 'Assistant' ,'F', '1970-02-19' ,  9000, 'B007'), 
                    ('SG5' , 'Susan' ,'Brand' , 'Manager'   ,'F', '1940-06-03' , 24000, 'B003'),
                    ('SL41', 'Julie' ,'Lee'   , 'Assistant' ,'F', '1965-06-13' ,  9000, 'B005');

  insert into CClient(clientNo,fName    ,lName   ,telNo    ,prefType,   maxRent, eMail)
  values            ('CR76', 'John' ,'Kay'     ,'0207-774-5632' ,'Flat' , 425, 'john.kay@gmail.com'),
                    ('CR56', 'Aline','Stewart' ,'0141-848-1825' ,'Flat' , 350, 'astewart@hotmail.com'), 
                    ('CR74', 'Mike' ,'Ritchie' ,'01475-392178'  ,'House', 750, 'mritchie01@yahoo.co.uk'),
                    ('CR62', 'Mary' ,'Tregear' ,'01224-196720'  ,'Flat' , 600, 'maryt@hotmail.com.uk');
                    
  insert into PropertyForRent(propertyNo,   street      ,  city    , postcode, pType  ,rooms, rent, ownerNo, staffNo, branchNo)
  values                     ('PA14'    ,'16 Holhead'   ,'Aberdeen','AB7 5SU','House',  6   , 650,  'CO46' , 'SA9'  , 'B007'),
                             ('PL94'    ,'6 Argyll St'  ,'London'  ,'NW2'    ,'Flat' ,  4   , 400,  'CO87' , 'SL41' , 'B005'), 
                             ('PG4'     ,'6 Lawrence St','Glasgow' ,'G11 9QX','Flat' ,  3   , 350,  'CO40' ,  NULL  , 'B003'),
                             ('PG36'    ,'2 Manor Rd'   ,'Glasgow' ,'G32 4QX','Flat' ,  3   , 375,  'CO93' , 'SG37' , 'B003'),
                             ('PG21'    ,'18 Dale Rd'   ,'Glasgow' ,'G12'    ,'House',  5   , 600,  'CO87' , 'SG37' , 'B003'),
                             ('PG16'    ,'5 Novar Dr'   ,'Glasgow' ,'G12 9AX','Flat' ,  4   , 450,  'CO93' , 'SG14' , 'B003');
                    
  insert into Viewing(clientNo, propertyNo, viewDate    , vComment)
  values             ('CR56'  , 'PA14'    ,'2013-05-24 10:00' ,'too small'     ),
                     ('CR76'  , 'PG4'     ,'2013-04-20 8:35'  ,'too remote'    ), 
                     ('CR56'  , 'PG4'     ,'2013-05-26 16:45' , NULL           ),
                     ('CR62'  , 'PA14'    ,'2013-05-14 13:32' ,'no dining room'),
                     ('CR56'  , 'PG36'    ,'2013-04-28 11:00' , NULL           );

  insert into Registration
  values             ('CR76', 'B005', 'SL41', '2013-01-02'), 
                     ('CR56', 'B003', 'SG37', '2013-04-11'),
                     ('CR74', 'B003', 'SG37', '2013-11-16'),
                     ('CR62', 'B007', 'SA9' , '2013-03-07');

SELECT * FROM Branch;
SELECT * FROM PropertyForRent;
SELECT * FROM PrivateOwner;
SELECT * FROM Registration;
SELECT * FROM Viewing;
SELECT * FROM Staff;
SELECT * FROM CClient;

drop database sample2312;