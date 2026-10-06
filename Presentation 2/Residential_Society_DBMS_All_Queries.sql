-- ============================================================
-- RESIDENTIAL SOCIETY MANAGEMENT & MAINTENANCE BILLING SYSTEM
-- Complete MySQL script: database creation, tables, sample data,
-- CRUD examples, reports and presentation queries.
-- Student: Sri Pranav Ramini
-- Roll No: 25WU0102273
-- ============================================================

DROP DATABASE IF EXISTS Residential_Society_DB;
CREATE DATABASE Residential_Society_DB;
USE Residential_Society_DB;

-- ============================================================
-- 1. TABLE CREATION
-- ============================================================

CREATE TABLE SOCIETY (
    Society_ID INT PRIMARY KEY AUTO_INCREMENT,
    Society_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Registration_No VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE FLAT (
    Flat_ID INT PRIMARY KEY AUTO_INCREMENT,
    Flat_Number VARCHAR(20) NOT NULL,
    Floor INT NOT NULL,
    Block VARCHAR(10) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Area DECIMAL(10,2) NOT NULL,
    Society_ID INT NOT NULL,
    FOREIGN KEY (Society_ID) REFERENCES SOCIETY(Society_ID)
);

CREATE TABLE RESIDENT (
    Resident_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Email VARCHAR(100),
    Occupation VARCHAR(100),
    Flat_ID INT NOT NULL,
    FOREIGN KEY (Flat_ID) REFERENCES FLAT(Flat_ID)
);

CREATE TABLE COMPLAINT (
    Complaint_ID INT PRIMARY KEY AUTO_INCREMENT,
    Complaint_Date DATE NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Status ENUM('Pending','In Progress','Resolved') NOT NULL DEFAULT 'Pending',
    Flat_ID INT NOT NULL,
    FOREIGN KEY (Flat_ID) REFERENCES FLAT(Flat_ID)
);

CREATE TABLE MAINTENANCE_TYPE (
    Maintenance_Type_ID INT PRIMARY KEY AUTO_INCREMENT,
    Type_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Rate DECIMAL(10,2) NOT NULL
);

CREATE TABLE MAINTENANCE_BILL (
    Bill_ID INT PRIMARY KEY AUTO_INCREMENT,
    Bill_Date DATE NOT NULL,
    Due_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Status ENUM('Paid','Pending') NOT NULL DEFAULT 'Pending',
    Flat_ID INT NOT NULL,
    FOREIGN KEY (Flat_ID) REFERENCES FLAT(Flat_ID)
);

CREATE TABLE PAYMENT (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Payment_Date DATE NOT NULL,
    Amount_Paid DECIMAL(10,2) NOT NULL,
    Payment_Mode ENUM('UPI','NEFT','Card','Cash') NOT NULL,
    Transaction_ID VARCHAR(50) NOT NULL UNIQUE,
    Bill_ID INT NOT NULL,
    FOREIGN KEY (Bill_ID) REFERENCES MAINTENANCE_BILL(Bill_ID)
);

CREATE TABLE BILL_DETAIL (
    Bill_Detail_ID INT PRIMARY KEY AUTO_INCREMENT,
    Bill_ID INT NOT NULL,
    Maintenance_Type_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Rate DECIMAL(10,2) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Bill_ID) REFERENCES MAINTENANCE_BILL(Bill_ID),
    FOREIGN KEY (Maintenance_Type_ID)
        REFERENCES MAINTENANCE_TYPE(Maintenance_Type_ID)
);

-- ============================================================
-- 2. SAMPLE DATA
-- ============================================================

INSERT INTO SOCIETY (Society_Name, Address, Registration_No) VALUES
('Green Valley Apartments','Madhapur, Hyderabad','REG001'),
('Sunrise Residency','Kondapur, Hyderabad','REG002'),
('Lake View Society','Gachibowli, Hyderabad','REG003'),
('Royal Heights','Kukatpally, Hyderabad','REG004'),
('Palm Residency','Miyapur, Hyderabad','REG005'),
('Silver Springs','Manikonda, Hyderabad','REG006'),
('Happy Homes','Nallagandla, Hyderabad','REG007'),
('Skyline Residency','Hitech City, Hyderabad','REG008'),
('Garden Enclave','Begumpet, Hyderabad','REG009'),
('Pearl Towers','Banjara Hills, Hyderabad','REG010'),
('Elite Residency','Jubilee Hills, Hyderabad','REG011'),
('Sai Krupa Homes','Ameerpet, Hyderabad','REG012'),
('Urban Nest','Secunderabad, Hyderabad','REG013'),
('Blue Horizon','Kompally, Hyderabad','REG014'),
('Maple Heights','LB Nagar, Hyderabad','REG015'),
('Golden Park','Uppal, Hyderabad','REG016'),
('Spring Meadows','Tarnaka, Hyderabad','REG017'),
('Green Meadows','Kothapet, Hyderabad','REG018'),
('Oak Residency','Dilsukhnagar, Hyderabad','REG019'),
('Crystal Homes','Mehdipatnam, Hyderabad','REG020'),
('Royal Orchid','Tolichowki, Hyderabad','REG021'),
('Metro Heights','Moosapet, Hyderabad','REG022'),
('Harmony Homes','Chandanagar, Hyderabad','REG023'),
('City View Residency','Attapur, Hyderabad','REG024'),
('Sunshine Towers','Masab Tank, Hyderabad','REG025');

INSERT INTO FLAT (Flat_Number, Floor, Block, Type, Area, Society_ID) VALUES
('A101',1,'A','2BHK',1050,1),
('A102',1,'A','2BHK',1100,1),
('A201',2,'A','3BHK',1350,1),
('A202',2,'A','2BHK',1080,1),
('B101',1,'B','2BHK',1000,2),
('B102',1,'B','3BHK',1400,2),
('B201',2,'B','2BHK',1050,2),
('B202',2,'B','3BHK',1450,2),
('C101',1,'C','2BHK',1020,3),
('C102',1,'C','2BHK',1070,3),
('C201',2,'C','3BHK',1500,3),
('C202',2,'C','2BHK',1090,3),
('D101',1,'D','2BHK',1010,4),
('D102',1,'D','3BHK',1420,4),
('D201',2,'D','2BHK',1060,4),
('D202',2,'D','3BHK',1480,4),
('E101',1,'E','2BHK',1030,5),
('E102',1,'E','2BHK',1080,5),
('E201',2,'E','3BHK',1380,5),
('E202',2,'E','2BHK',1110,5),
('F101',1,'F','2BHK',1040,6),
('F102',1,'F','3BHK',1430,6),
('F201',2,'F','2BHK',1070,6),
('F202',2,'F','3BHK',1490,6),
('G101',1,'G','2BHK',1060,7);

INSERT INTO RESIDENT (Name, Phone, Email, Occupation, Flat_ID) VALUES
('Aarav Sharma','9000000001','aarav@example.com','Engineer',1),
('Priya Nair','9000000002','priya@example.com','Doctor',2),
('Rahul Verma','9000000003','rahul@example.com','Teacher',3),
('Sneha Reddy','9000000004','sneha@example.com','Designer',4),
('Kiran Kumar','9000000005','kiran@example.com','Developer',5),
('Meera Iyer','9000000006','meera@example.com','Lawyer',6),
('Rohan Das','9000000007','rohan@example.com','Manager',7),
('Ananya Gupta','9000000008','ananya@example.com','Analyst',8),
('Vikram Singh','9000000009','vikram@example.com','Consultant',9),
('Ishita Patel','9000000010','ishita@example.com','Architect',10),
('Nikhil Reddy','9000000011','nikhil@example.com','Engineer',11),
('Aditi Rao','9000000012','aditi@example.com','HR Manager',12),
('Arjun Mehta','9000000013','arjun@example.com','Businessman',13),
('Neha Kapoor','9000000014','neha@example.com','Accountant',14),
('Manish Rao','9000000015','manish@example.com','Developer',15),
('Divya Sharma','9000000016','divya@example.com','Professor',16),
('Karthik Rao','9000000017','karthik@example.com','Engineer',17),
('Meghana Rao','9000000018','meghana@example.com','Designer',18),
('Rohit Kumar','9000000019','rohit@example.com','Analyst',19),
('Priya Menon','9000000020','priyamenon@example.com','Nurse',20),
('Raj Kumar','9000000021','raj@example.com','Manager',21),
('Sonal Shah','9000000022','sonal@example.com','Teacher',22),
('Aditya Sharma','9000000023','aditya@example.com','Developer',23),
('Pooja Reddy','9000000024','pooja@example.com','Consultant',24),
('Dr. Nagaraju D','9000000025','nagaraju@example.com','Professor',25);

INSERT INTO COMPLAINT (Complaint_Date, Description, Status, Flat_ID) VALUES
('2026-09-01','Water leakage','Resolved',1),
('2026-09-02','Lift not working','Resolved',2),
('2026-09-03','Parking issue','Resolved',3),
('2026-09-04','Power fluctuation','Resolved',4),
('2026-09-05','Security concern','Resolved',5),
('2026-09-06','Water supply issue','Resolved',6),
('2026-09-07','Garbage collection delay','Resolved',7),
('2026-09-08','Street light issue','Resolved',8),
('2026-09-09','Plumbing issue','Resolved',9),
('2026-09-10','Lift maintenance','Resolved',10),
('2026-09-11','Common area cleaning','Resolved',11),
('2026-09-12','Water tank cleaning','Resolved',12),
('2026-09-13','Pest control required','Pending',13),
('2026-09-14','Parking allocation','Pending',14),
('2026-09-15','Intercom issue','Pending',15),
('2026-09-16','Door repair','Pending',16),
('2026-09-17','Drainage issue','Pending',17),
('2026-09-18','Garden maintenance','Pending',18),
('2026-09-19','Noise complaint','Pending',19),
('2026-09-20','Security camera issue','Pending',20),
('2026-09-21','Elevator noise','In Progress',21),
('2026-09-22','Common light issue','In Progress',22),
('2026-09-23','Water pressure issue','In Progress',23),
('2026-09-24','Parking gate issue','In Progress',24),
('2026-09-25','Cleaning request','In Progress',25);

INSERT INTO MAINTENANCE_TYPE (Type_Name, Description, Rate) VALUES
('Water','Monthly water maintenance',500),
('Security','Security services',700),
('Cleaning','Common area cleaning',600),
('Lift','Lift maintenance',450),
('Power Backup','Generator and power backup',550),
('Gardening','Garden maintenance',350),
('Waste Management','Waste collection',400),
('Pest Control','Pest control service',300),
('Repairs','General repairs',800),
('Clubhouse','Clubhouse maintenance',650),
('Swimming Pool','Pool maintenance',750),
('Parking','Parking maintenance',500),
('Fire Safety','Fire safety maintenance',450),
('CCTV','CCTV maintenance',350),
('Common Electricity','Common electricity',900),
('Internet','Society internet service',300),
('Painting','Common area painting',1000),
('Plumbing','Plumbing maintenance',600),
('Generator','Generator maintenance',700),
('Administration','Administrative charges',400),
('Insurance','Society insurance',850),
('Equipment','Equipment maintenance',500),
('Road Maintenance','Internal road maintenance',450),
('Festival','Festival/common events',250),
('Miscellaneous','Miscellaneous society expenses',300);

INSERT INTO MAINTENANCE_BILL (Bill_Date, Due_Date, Amount, Status, Flat_ID) VALUES
('2026-09-01','2026-09-10',3500,'Pending',1),
('2026-09-01','2026-09-10',3600,'Paid',2),
('2026-09-02','2026-09-10',3700,'Paid',3),
('2026-09-02','2026-09-10',3200,'Paid',4),
('2026-09-03','2026-09-10',3400,'Pending',5),
('2026-09-03','2026-09-10',4500,'Paid',6),
('2026-09-04','2026-09-10',3300,'Pending',7),
('2026-09-04','2026-09-10',4600,'Paid',8),
('2026-09-05','2026-09-10',3100,'Paid',9),
('2026-09-05','2026-09-10',3300,'Paid',10),
('2026-09-06','2026-09-10',4400,'Pending',11),
('2026-09-06','2026-09-10',3500,'Paid',12),
('2026-09-07','2026-09-10',3600,'Pending',13),
('2026-09-07','2026-09-10',3400,'Pending',14),
('2026-09-08','2026-09-10',3500,'Pending',15),
('2026-09-08','2026-09-10',3600,'Pending',16),
('2026-09-09','2026-09-10',3700,'Pending',17),
('2026-09-09','2026-09-10',3800,'Pending',18),
('2026-09-10','2026-09-15',3900,'Pending',19),
('2026-09-10','2026-09-15',4000,'Pending',20),
('2026-09-11','2026-09-15',4100,'Paid',21),
('2026-09-11','2026-09-15',4200,'Paid',22),
('2026-09-12','2026-09-15',4300,'Paid',23),
('2026-09-12','2026-09-15',4400,'Paid',24),
('2026-09-13','2026-09-15',4500,'Paid',25);

INSERT INTO PAYMENT (Payment_Date, Amount_Paid, Payment_Mode, Transaction_ID, Bill_ID) VALUES
('2026-09-02',3600,'UPI','TXN10001',2),
('2026-09-03',3700,'Card','TXN10002',3),
('2026-09-03',3200,'Cash','TXN10003',4),
('2026-09-04',4500,'UPI','TXN10004',6),
('2026-09-05',4600,'NEFT','TXN10005',8),
('2026-09-06',3100,'UPI','TXN10006',9),
('2026-09-06',3300,'Card','TXN10007',10),
('2026-09-07',3500,'Cash','TXN10008',12),
('2026-09-08',4100,'UPI','TXN10009',21),
('2026-09-08',4200,'Card','TXN10010',22),
('2026-09-09',4300,'NEFT','TXN10011',23),
('2026-09-09',4400,'UPI','TXN10012',24),
('2026-09-10',4500,'Card','TXN10013',25),
('2026-09-10',3600,'UPI','TXN10014',2),
('2026-09-11',3700,'Card','TXN10015',3),
('2026-09-11',3200,'Cash','TXN10016',4),
('2026-09-12',4500,'UPI','TXN10017',6),
('2026-09-12',4600,'NEFT','TXN10018',8),
('2026-09-13',3100,'UPI','TXN10019',9),
('2026-09-13',3300,'Card','TXN10020',10),
('2026-09-14',3500,'Cash','TXN10021',12),
('2026-09-14',4100,'UPI','TXN10022',21),
('2026-09-15',4200,'Card','TXN10023',22),
('2026-09-15',4300,'NEFT','TXN10024',23),
('2026-09-16',4500,'Card','TXN10025',25);

INSERT INTO BILL_DETAIL (Bill_ID, Maintenance_Type_ID, Quantity, Rate, Amount) VALUES
(1,1,1,500,500),(2,2,1,700,700),(3,3,1,600,600),(4,4,1,450,450),
(5,5,1,550,550),(6,6,1,350,350),(7,7,1,400,400),(8,8,1,300,300),
(9,9,1,800,800),(10,10,1,650,650),(11,11,1,750,750),(12,12,1,500,500),
(13,13,1,450,450),(14,14,1,350,350),(15,15,1,900,900),(16,16,1,300,300),
(17,17,1,1000,1000),(18,18,1,600,600),(19,19,1,700,700),(20,20,1,400,400),
(21,21,1,850,850),(22,22,1,500,500),(23,23,1,450,450),(24,24,1,250,250),
(25,25,1,300,300);

-- ============================================================
-- 3. BASIC VERIFICATION
-- ============================================================

SHOW TABLES;

SELECT * FROM SOCIETY;
SELECT * FROM FLAT;
SELECT * FROM RESIDENT;
SELECT * FROM COMPLAINT;
SELECT * FROM MAINTENANCE_TYPE;
SELECT * FROM MAINTENANCE_BILL;
SELECT * FROM PAYMENT;
SELECT * FROM BILL_DETAIL;

-- ============================================================
-- 4. REPRESENTATIVE CRUD QUERIES
-- ============================================================

-- CREATE
INSERT INTO RESIDENT (Name, Phone, Email, Occupation, Flat_ID)
VALUES ('Demo Resident','9999999999','demo@example.com','Student',1);

-- READ
SELECT * FROM RESIDENT WHERE Resident_ID = LAST_INSERT_ID();

-- UPDATE
UPDATE RESIDENT
SET Occupation = 'Software Engineer'
WHERE Resident_ID = LAST_INSERT_ID();

-- DELETE
-- Run only for the demo record created above.
DELETE FROM RESIDENT
WHERE Phone = '9999999999';

-- ============================================================
-- 5. REPORT / PRESENTATION QUERIES
-- ============================================================

-- Query 1: Number of complaints by status
SELECT
    Status,
    COUNT(*) AS Number_of_Complaints
FROM COMPLAINT
GROUP BY Status;

-- Query 2: Total maintenance amount
SELECT
    SUM(Amount) AS Total_Maintenance_Amount
FROM MAINTENANCE_BILL;

-- Query 3: Number of residents in each flat
SELECT
    F.Flat_Number,
    COUNT(R.Resident_ID) AS Number_of_Residents
FROM FLAT F
LEFT JOIN RESIDENT R
    ON F.Flat_ID = R.Flat_ID
GROUP BY F.Flat_ID, F.Flat_Number
ORDER BY F.Flat_ID;

-- Query 4: Flats with society names (JOIN)
SELECT
    F.Flat_Number,
    F.Block,
    F.Floor,
    F.Type,
    F.Area,
    S.Society_Name
FROM FLAT F
JOIN SOCIETY S
    ON F.Society_ID = S.Society_ID;

-- Query 5: Residents with flat details
SELECT
    R.Resident_ID,
    R.Name,
    R.Phone,
    R.Email,
    F.Flat_Number,
    S.Society_Name
FROM RESIDENT R
JOIN FLAT F
    ON R.Flat_ID = F.Flat_ID
JOIN SOCIETY S
    ON F.Society_ID = S.Society_ID;

-- Query 6: Pending maintenance bills
SELECT
    B.Bill_ID,
    F.Flat_Number,
    B.Amount,
    B.Due_Date,
    B.Status
FROM MAINTENANCE_BILL B
JOIN FLAT F
    ON B.Flat_ID = F.Flat_ID
WHERE B.Status = 'Pending';

-- Query 7: Payment history
SELECT
    P.Payment_ID,
    P.Payment_Date,
    F.Flat_Number,
    P.Amount_Paid,
    P.Payment_Mode,
    P.Transaction_ID
FROM PAYMENT P
JOIN MAINTENANCE_BILL B
    ON P.Bill_ID = B.Bill_ID
JOIN FLAT F
    ON B.Flat_ID = F.Flat_ID
ORDER BY P.Payment_Date;

-- Query 8: Complaint details with flat information
SELECT
    C.Complaint_ID,
    C.Complaint_Date,
    F.Flat_Number,
    C.Description,
    C.Status
FROM COMPLAINT C
JOIN FLAT F
    ON C.Flat_ID = F.Flat_ID;

-- Query 9: Bill details with maintenance type
SELECT
    BD.Bill_Detail_ID,
    BD.Bill_ID,
    MT.Type_Name,
    BD.Quantity,
    BD.Rate,
    BD.Amount
FROM BILL_DETAIL BD
JOIN MAINTENANCE_TYPE MT
    ON BD.Maintenance_Type_ID = MT.Maintenance_Type_ID;

-- Query 10: Total payments collected
SELECT
    SUM(Amount_Paid) AS Total_Payments_Collected
FROM PAYMENT;

-- Query 11: Count flats in each society
SELECT
    S.Society_Name,
    COUNT(F.Flat_ID) AS Number_of_Flats
FROM SOCIETY S
LEFT JOIN FLAT F
    ON S.Society_ID = F.Society_ID
GROUP BY S.Society_ID, S.Society_Name;

-- Query 12: Complaint count by status with ordering
SELECT
    Status,
    COUNT(*) AS Number_of_Complaints
FROM COMPLAINT
GROUP BY Status
ORDER BY Number_of_Complaints DESC;

-- Query 13: Average maintenance bill
SELECT
    AVG(Amount) AS Average_Maintenance_Bill
FROM MAINTENANCE_BILL;

-- Query 14: Highest maintenance bill
SELECT
    MAX(Amount) AS Highest_Maintenance_Bill
FROM MAINTENANCE_BILL;

-- Query 15: Flats with pending bills
SELECT
    F.Flat_Number,
    S.Society_Name,
    B.Amount,
    B.Due_Date
FROM MAINTENANCE_BILL B
JOIN FLAT F ON B.Flat_ID = F.Flat_ID
JOIN SOCIETY S ON F.Society_ID = S.Society_ID
WHERE B.Status = 'Pending'
ORDER BY B.Due_Date;

-- ============================================================
-- 6. FINAL DATABASE CHECK
-- ============================================================

SELECT 'SOCIETY' AS Table_Name, COUNT(*) AS Record_Count FROM SOCIETY
UNION ALL
SELECT 'FLAT', COUNT(*) FROM FLAT
UNION ALL
SELECT 'RESIDENT', COUNT(*) FROM RESIDENT
UNION ALL
SELECT 'COMPLAINT', COUNT(*) FROM COMPLAINT
UNION ALL
SELECT 'MAINTENANCE_TYPE', COUNT(*) FROM MAINTENANCE_TYPE
UNION ALL
SELECT 'MAINTENANCE_BILL', COUNT(*) FROM MAINTENANCE_BILL
UNION ALL
SELECT 'PAYMENT', COUNT(*) FROM PAYMENT
UNION ALL
SELECT 'BILL_DETAIL', COUNT(*) FROM BILL_DETAIL;

-- END OF SCRIPT
