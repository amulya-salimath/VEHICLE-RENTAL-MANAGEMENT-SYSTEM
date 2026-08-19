/* ====================================================================
   VEHICLE RENTAL MANAGEMENT SYSTEM
   Complete MySQL Project - built topic-wise per client requirement doc
   ==================================================================== */


/* ====================================================================
   SECTION 1: DATABASE & TABLE CREATION
   ==================================================================== */

DROP DATABASE IF EXISTS vehicle_rental_db;
CREATE DATABASE vehicle_rental_db;
USE vehicle_rental_db;

-- ---------------------------------------------------
-- 1. CUSTOMERS TABLE
-- ---------------------------------------------------
CREATE TABLE Customers (
    Customer_ID         INT PRIMARY KEY,
    Name                VARCHAR(100) NOT NULL,
    Phone               VARCHAR(15)  NOT NULL UNIQUE,
    Email               VARCHAR(100) UNIQUE,
    Address             VARCHAR(100),
    Driving_License_No  VARCHAR(30)  NOT NULL UNIQUE
);

INSERT INTO Customers
(Customer_ID, Name, Phone, Email, Address, Driving_License_No)
VALUES
(1,  'Rahul Sharma', '9876543210', 'rahul@gmail.com',  'Bengaluru',  'DL10001'),
(2,  'Priya Patel',  '9876543211', 'priya@gmail.com',  'Mysuru',     'DL10002'),
(3,  'Arjun Kumar',  '9876543212', 'arjun@gmail.com',  'Chennai',    'DL10003'),
(4,  'Sneha Reddy',  '9876543213', 'sneha@gmail.com',  'Hyderabad',  'DL10004'),
(5,  'Vikram Singh', '9876543214', 'vikram@gmail.com', 'Mumbai',     'DL10005'),
(6,  'Ananya Rao',   '9876543215', 'ananya@gmail.com', 'Bengaluru',  'DL10006'),
(7,  'Karan Mehta',  '9876543216', 'karan@gmail.com',  'Pune',       'DL10007'),
(8,  'Neha Joshi',   '9876543217', 'neha@gmail.com',   'Delhi',      'DL10008'),
(9,  'Rohan Das',    '9876543218', 'rohan@gmail.com',  'Kolkata',    'DL10009'),
(10, 'Meera Nair',   '9876543219', 'meera@gmail.com',  'Kochi',      'DL10010'),
(11, 'Amit Verma',   '9876543220', 'amit@gmail.com',   'Jaipur',     'DL10011'),
(12, 'Pooja Shah',   '9876543221', 'pooja@gmail.com',  'Ahmedabad',  'DL10012'),
(13, 'Suresh Babu',  '9876543222', 'suresh@gmail.com', 'Bengaluru',  'DL10013'),
(14, 'Divya Menon',  '9876543223', 'divya@gmail.com',  'Kochi',      'DL10014'),
(15, 'Manish Gupta', '9876543224', 'manish@gmail.com', 'Lucknow',    'DL10015'),
(16, 'Kavya Iyer',   '9876543225', 'kavya@gmail.com',  'Chennai',    'DL10016'),
(17, 'Aditya Jain',  '9876543226', 'aditya@gmail.com', 'Indore',     'DL10017'),
(18, 'Nisha Kapoor', '9876543227', 'nisha@gmail.com',  'Delhi',      'DL10018'),
(19, 'Naveen Kumar', '9876543228', 'naveen@gmail.com', 'Hyderabad',  'DL10019'),
(20, 'Shreya Roy',   '9876543229', 'shreya@gmail.com', 'Kolkata',    'DL10020'),
-- Extra customer with NO rentals, used later in Section 10 (LEFT JOIN) and
-- Section 15 (DELETE), so both "zero-rental" scenarios are demonstrable.
(21, 'Farhan Ali',   '9876543230', 'farhan@gmail.com', 'Bengaluru',  'DL10021');

-- ---------------------------------------------------
-- 2. VEHICLES TABLE
-- ---------------------------------------------------
CREATE TABLE Vehicles (
    Vehicle_ID           INT PRIMARY KEY,
    Vehicle_Number       VARCHAR(20) NOT NULL UNIQUE,
    Vehicle_Type         VARCHAR(30) NOT NULL,
    Brand                VARCHAR(50) NOT NULL,
    Model                VARCHAR(50) NOT NULL,
    Rental_Rate_Per_Day  DECIMAL(10,2) NOT NULL CHECK (Rental_Rate_Per_Day >= 0),
    Availability_Status  VARCHAR(20) NOT NULL DEFAULT 'Available'
                          CHECK (Availability_Status IN ('Available','Rented','Maintenance'))
);

INSERT INTO Vehicles
(Vehicle_ID, Vehicle_Number, Vehicle_Type, Brand, Model, Rental_Rate_Per_Day, Availability_Status)
VALUES
(1,  'KA01AB1001', 'Car', 'Maruti',     'Swift',    1800, 'Available'),
(2,  'KA01AB1002', 'Car', 'Hyundai',    'Creta',    2800, 'Rented'),
(3,  'KA01AB1003', 'Car', 'Tata',       'Nexon',    2200, 'Available'),
(4,  'KA01AB1004', 'Car', 'Toyota',     'Innova',   3500, 'Available'),
(5,  'KA01AB1005', 'Car', 'Honda',      'City',     2500, 'Maintenance'),
(6,  'KA01AB1006', 'SUV', 'Mahindra',   'XUV700',   3200, 'Available'),
(7,  'KA01AB1007', 'Car', 'Kia',        'Seltos',   2900, 'Rented'),
(8,  'KA01AB1008', 'Car', 'Maruti',     'Baleno',   1700, 'Available'),
(9,  'KA01AB1009', 'SUV', 'Toyota',     'Fortuner', 5000, 'Available'),
(10, 'KA01AB1010', 'Car', 'Hyundai',    'i20',      1600, 'Rented'),
(11, 'KA01AB1011', 'Car', 'Honda',      'Amaze',    1900, 'Available'),
(12, 'KA01AB1012', 'SUV', 'Tata',       'Harrier',  3000, 'Available'),
(13, 'KA01AB1013', 'Car', 'Renault',    'Kwid',     1400, 'Maintenance'),
(14, 'KA01AB1014', 'Car', 'Volkswagen', 'Virtus',   2700, 'Available'),
(15, 'KA01AB1015', 'SUV', 'MG',         'Hector',   3100, 'Rented'),
(16, 'KA01AB1016', 'Car', 'Skoda',      'Slavia',   2600, 'Available'),
(17, 'KA01AB1017', 'Car', 'Maruti',     'Dzire',    1800, 'Available'),
(18, 'KA01AB1018', 'SUV', 'Hyundai',    'Alcazar',  3300, 'Available'),
(19, 'KA01AB1019', 'Car', 'Tata',       'Altroz',   1750, 'Rented'),
(20, 'KA01AB1020', 'SUV', 'Mahindra',   'Scorpio',  3400, 'Available'),
-- Extra vehicle, never rented and never serviced, used in Section 10 (LEFT JOIN)
(21, 'KA01AB1021', 'Car', 'Nissan',     'Magnite',  1650, 'Available');

-- ---------------------------------------------------
-- 3. RENTALS TABLE
-- ---------------------------------------------------
CREATE TABLE Rentals (
    Rental_ID      INT PRIMARY KEY,
    Customer_ID    INT NOT NULL,
    Vehicle_ID     INT NOT NULL,
    Rental_Date    DATE NOT NULL,
    Return_Date    DATE,
    Total_Days     INT NOT NULL CHECK (Total_Days > 0),
    Rental_Status  VARCHAR(20) NOT NULL DEFAULT 'Completed'
                   CHECK (Rental_Status IN ('Ongoing','Completed','Cancelled')),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Vehicle_ID)  REFERENCES Vehicles(Vehicle_ID)
);

INSERT INTO Rentals
(Rental_ID, Customer_ID, Vehicle_ID, Rental_Date, Return_Date, Total_Days, Rental_Status)
VALUES
(1,  1,  2,  '2026-01-05', '2026-01-08', 3, 'Completed'),
(2,  2,  4,  '2026-01-10', '2026-01-13', 3, 'Completed'),
(3,  3,  1,  '2026-01-15', '2026-01-17', 2, 'Completed'),
(4,  4,  7,  '2026-01-20', '2026-01-25', 5, 'Completed'),
(5,  5,  5,  '2026-02-01', '2026-02-04', 3, 'Completed'),
(6,  6,  9,  '2026-02-05', '2026-02-08', 3, 'Completed'),
(7,  7,  10, '2026-02-10', '2026-02-12', 2, 'Completed'),
(8,  8,  3,  '2026-02-15', '2026-02-19', 4, 'Completed'),
(9,  9,  15, '2026-02-20', '2026-02-24', 4, 'Completed'),
(10, 10, 6,  '2026-03-01', '2026-03-05', 4, 'Completed'),
(11, 11, 8,  '2026-03-05', '2026-03-07', 2, 'Completed'),
(12, 12, 12, '2026-03-10', '2026-03-14', 4, 'Completed'),
(13, 13, 14, '2026-03-15', '2026-03-18', 3, 'Completed'),
(14, 14, 17, '2026-03-20', '2026-03-23', 3, 'Completed'),
(15, 15, 18, '2026-04-01', '2026-04-06', 5, 'Completed'),
(16, 16, 16, '2026-04-10', '2026-04-13', 3, 'Completed'),
(17, 17, 19, '2026-04-15', '2026-04-18', 3, 'Completed'),
(18, 18, 20, '2026-04-20', '2026-04-22', 2, 'Completed'),
(19, 19, 11, '2026-05-01', '2026-05-05', 4, 'Completed'),
(20, 20, 13, '2026-05-10', '2026-05-13', 3, 'Completed');

-- ---------------------------------------------------
-- 4. PAYMENTS TABLE
-- ---------------------------------------------------
CREATE TABLE Payments (
    Payment_ID      INT PRIMARY KEY,
    Rental_ID       INT NOT NULL,
    Payment_Date    DATE NOT NULL,
    Amount          DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
    Payment_Method  VARCHAR(20) NOT NULL CHECK (Payment_Method IN ('Cash','UPI','Card')),
    Payment_Status  VARCHAR(20) NOT NULL DEFAULT 'Paid'
                    CHECK (Payment_Status IN ('Paid','Pending','Failed')),
    FOREIGN KEY (Rental_ID) REFERENCES Rentals(Rental_ID)
);

INSERT INTO Payments
(Payment_ID, Rental_ID, Payment_Date, Amount, Payment_Method, Payment_Status)
VALUES
(1,  1,  '2026-01-05', 8400,  'UPI',  'Paid'),
(2,  2,  '2026-01-10', 10500, 'Card', 'Paid'),
(3,  3,  '2026-01-15', 3600,  'Cash', 'Paid'),
(4,  4,  '2026-01-20', 14500, 'UPI',  'Paid'),
(5,  5,  '2026-02-01', 7500,  'Card', 'Paid'),
(6,  6,  '2026-02-05', 15000, 'UPI',  'Paid'),
(7,  7,  '2026-02-10', 3200,  'Cash', 'Paid'),
(8,  8,  '2026-02-15', 8800,  'Card', 'Paid'),
(9,  9,  '2026-02-20', 12400, 'UPI',  'Paid'),
(10, 10, '2026-03-01', 12800, 'Card', 'Paid'),
(11, 11, '2026-03-05', 3400,  'Cash', 'Paid'),
(12, 12, '2026-03-10', 12000, 'UPI',  'Paid'),
(13, 13, '2026-03-15', 8100,  'Card', 'Paid'),
(14, 14, '2026-03-20', 5400,  'UPI',  'Paid'),
(15, 15, '2026-04-01', 16500, 'Card', 'Paid'),
(16, 16, '2026-04-10', 7800,  'UPI',  'Paid'),
(17, 17, '2026-04-15', 5250,  'Cash', 'Paid'),
(18, 18, '2026-04-20', 6800,  'Card', 'Paid'),
(19, 19, '2026-05-01', 7600,  'UPI',  'Paid'),
(20, 20, '2026-05-10', 4200,  'Cash', 'Paid');

-- ---------------------------------------------------
-- 5. MAINTENANCE TABLE
-- ---------------------------------------------------
CREATE TABLE Maintenance (
    Maintenance_ID       INT PRIMARY KEY,
    Vehicle_ID           INT NOT NULL,
    Maintenance_Date     DATE NOT NULL,
    Description          VARCHAR(150),
    Cost                 DECIMAL(10,2) NOT NULL CHECK (Cost >= 0),
    Maintenance_Status   VARCHAR(20) NOT NULL DEFAULT 'Completed'
                         CHECK (Maintenance_Status IN ('Completed','In Progress','Pending')),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);

INSERT INTO Maintenance
(Maintenance_ID, Vehicle_ID, Maintenance_Date, Description, Cost, Maintenance_Status)
VALUES
(1,  1,  '2026-01-03', 'Engine Oil Change',     2500, 'Completed'),
(2,  2,  '2026-01-09', 'Brake Inspection',      4000, 'Completed'),
(3,  3,  '2026-01-18', 'Tire Replacement',      12000,'Completed'),
(4,  4,  '2026-01-25', 'General Service',       3500, 'Completed'),
(5,  5,  '2026-02-02', 'Engine Repair',         15000,'Completed'),
(6,  6,  '2026-02-10', 'Oil Change',            2800, 'Completed'),
(7,  7,  '2026-02-18', 'Brake Repair',          6000, 'Completed'),
(8,  8,  '2026-02-25', 'Battery Replacement',   7500, 'Completed'),
(9,  9,  '2026-03-02', 'Tire Service',          5000, 'Completed'),
(10, 10, '2026-03-08', 'AC Service',            4500, 'Completed'),
(11, 11, '2026-03-15', 'Oil Change',            2200, 'Completed'),
(12, 12, '2026-03-22', 'General Service',       3800, 'Completed'),
(13, 13, '2026-04-01', 'Engine Repair',         11000,'Completed'),
(14, 14, '2026-04-08', 'Brake Inspection',      3000, 'Completed'),
(15, 15, '2026-04-15', 'Tire Replacement',      14000,'Completed'),
(16, 16, '2026-04-22', 'Battery Replacement',   7000, 'Completed'),
(17, 17, '2026-05-01', 'Oil Change',            2300, 'Completed'),
(18, 18, '2026-05-08', 'AC Repair',             6500, 'Completed'),
(19, 19, '2026-05-15', 'General Service',       3600, 'Completed'),
(20, 20, '2026-05-20', 'Brake Repair',          5500, 'Completed');


/* ====================================================================
   SECTION 2: SELECT & WHERE
   ==================================================================== */

-- Customers from Bengaluru
SELECT * FROM Customers WHERE Address = 'Bengaluru';

-- Available vehicles
SELECT * FROM Vehicles WHERE Availability_Status = 'Available';

-- Vehicles under maintenance
SELECT * FROM Vehicles WHERE Availability_Status = 'Maintenance';

-- All SUVs
SELECT * FROM Vehicles WHERE Vehicle_Type = 'SUV';

-- All Hyundai vehicles
SELECT * FROM Vehicles WHERE Brand = 'Hyundai';

-- Rental rate greater than 2500
SELECT * FROM Vehicles WHERE Rental_Rate_Per_Day > 2500;

-- Rental rate between 1500 and 3000
SELECT * FROM Vehicles WHERE Rental_Rate_Per_Day BETWEEN 1500 AND 3000;

-- Customers whose names start with A
SELECT * FROM Customers WHERE Name LIKE 'A%';

-- Customers whose email contains gmail
SELECT * FROM Customers WHERE Email LIKE '%gmail%';

-- Payments made using UPI
SELECT * FROM Payments WHERE Payment_Method = 'UPI';


/* ====================================================================
   SECTION 3: ORDER BY
   ==================================================================== */

-- Vehicles highest to lowest rental rate
SELECT * FROM Vehicles ORDER BY Rental_Rate_Per_Day DESC;

-- Vehicles lowest to highest rental rate
SELECT * FROM Vehicles ORDER BY Rental_Rate_Per_Day ASC;

-- Customers alphabetically
SELECT * FROM Customers ORDER BY Name ASC;

-- Rentals newest to oldest
SELECT * FROM Rentals ORDER BY Rental_Date DESC;

-- Maintenance records highest to lowest cost
SELECT * FROM Maintenance ORDER BY Cost DESC;


/* ====================================================================
   SECTION 4: AGGREGATE FUNCTIONS
   ==================================================================== */

-- Total number of customers
SELECT COUNT(*) AS Total_Customers FROM Customers;

-- Total number of vehicles
SELECT COUNT(*) AS Total_Vehicles FROM Vehicles;

-- Average rental rate
SELECT AVG(Rental_Rate_Per_Day) AS Avg_Rental_Rate FROM Vehicles;

-- Highest rental rate
SELECT MAX(Rental_Rate_Per_Day) AS Highest_Rental_Rate FROM Vehicles;

-- Lowest rental rate
SELECT MIN(Rental_Rate_Per_Day) AS Lowest_Rental_Rate FROM Vehicles;

-- Total revenue collected
SELECT SUM(Amount) AS Total_Revenue FROM Payments;

-- Average payment amount
SELECT AVG(Amount) AS Avg_Payment_Amount FROM Payments;

-- Total maintenance cost
SELECT SUM(Cost) AS Total_Maintenance_Cost FROM Maintenance;

-- Highest maintenance cost
SELECT MAX(Cost) AS Highest_Maintenance_Cost FROM Maintenance;

-- Lowest maintenance cost
SELECT MIN(Cost) AS Lowest_Maintenance_Cost FROM Maintenance;


/* ====================================================================
   SECTION 5: GROUP BY & HAVING
   ==================================================================== */

-- Number of customers in each city
SELECT Address AS City, COUNT(*) AS Customer_Count
FROM Customers
GROUP BY Address;

-- Number of vehicles for each brand
SELECT Brand, COUNT(*) AS Vehicle_Count
FROM Vehicles
GROUP BY Brand;

-- Number of vehicles for each vehicle type
SELECT Vehicle_Type, COUNT(*) AS Vehicle_Count
FROM Vehicles
GROUP BY Vehicle_Type;

-- Average rental rate for each vehicle type
SELECT Vehicle_Type, AVG(Rental_Rate_Per_Day) AS Avg_Rate
FROM Vehicles
GROUP BY Vehicle_Type;

-- Total revenue for each payment method
SELECT Payment_Method, SUM(Amount) AS Total_Revenue
FROM Payments
GROUP BY Payment_Method;

-- Number of payments for each payment method
SELECT Payment_Method, COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Payment_Method;

-- Total maintenance cost for each vehicle
SELECT Vehicle_ID, SUM(Cost) AS Total_Maintenance_Cost
FROM Maintenance
GROUP BY Vehicle_ID;

-- Average maintenance cost for each vehicle
SELECT Vehicle_ID, AVG(Cost) AS Avg_Maintenance_Cost
FROM Maintenance
GROUP BY Vehicle_ID;

-- Brands having more than one vehicle
SELECT Brand, COUNT(*) AS Vehicle_Count
FROM Vehicles
GROUP BY Brand
HAVING COUNT(*) > 1;

-- Payment methods where total revenue exceeds 20000
SELECT Payment_Method, SUM(Amount) AS Total_Revenue
FROM Payments
GROUP BY Payment_Method
HAVING SUM(Amount) > 20000;


/* ====================================================================
   SECTION 6: DATE FUNCTIONS
   ==================================================================== */

-- Rental date
SELECT Rental_ID, Rental_Date FROM Rentals;

-- Year from rental date
SELECT Rental_ID, YEAR(Rental_Date) AS Rental_Year FROM Rentals;

-- Month from rental date
SELECT Rental_ID, MONTH(Rental_Date) AS Rental_Month FROM Rentals;

-- Number of rentals made in each month
SELECT MONTH(Rental_Date) AS Rental_Month, COUNT(*) AS Rental_Count
FROM Rentals
GROUP BY MONTH(Rental_Date);

-- Number of rental days (already stored, recomputed here from dates)
SELECT Rental_ID, DATEDIFF(Return_Date, Rental_Date) AS Calculated_Days
FROM Rentals;

-- Payment dates in DD-MM-YYYY format
SELECT Payment_ID, DATE_FORMAT(Payment_Date, '%d-%m-%Y') AS Formatted_Payment_Date
FROM Payments;

-- Rentals made during a particular month (example: March)
SELECT * FROM Rentals WHERE MONTH(Rental_Date) = 3;

-- Rentals made during a particular year (example: 2026)
SELECT * FROM Rentals WHERE YEAR(Rental_Date) = 2026;


/* ====================================================================
   SECTION 7: CALCULATIONS & OPERATORS
   ==================================================================== */

-- Rental cost = Rental Rate x Total Days
SELECT r.Rental_ID, v.Rental_Rate_Per_Day, r.Total_Days,
       (v.Rental_Rate_Per_Day * r.Total_Days) AS Calculated_Rental_Cost
FROM Rentals r
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID;

-- Estimated monthly revenue per vehicle = Rental Rate x 30
SELECT Vehicle_ID, Rental_Rate_Per_Day, (Rental_Rate_Per_Day * 30) AS Estimated_Monthly_Revenue
FROM Vehicles;

-- Rental amount along with customer details
SELECT c.Customer_ID, c.Name, r.Rental_ID,
       (v.Rental_Rate_Per_Day * r.Total_Days) AS Rental_Amount
FROM Rentals r
JOIN Customers c ON r.Customer_ID = c.Customer_ID
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID;

-- Compare expected rental amount with actual payment
SELECT r.Rental_ID,
       (v.Rental_Rate_Per_Day * r.Total_Days) AS Expected_Amount,
       p.Amount AS Actual_Payment
FROM Rentals r
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID;

-- Rentals where payment is higher than expected
SELECT r.Rental_ID,
       (v.Rental_Rate_Per_Day * r.Total_Days) AS Expected_Amount,
       p.Amount AS Actual_Payment
FROM Rentals r
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
WHERE p.Amount > (v.Rental_Rate_Per_Day * r.Total_Days);

-- Rentals where payment is lower than expected
SELECT r.Rental_ID,
       (v.Rental_Rate_Per_Day * r.Total_Days) AS Expected_Amount,
       p.Amount AS Actual_Payment
FROM Rentals r
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
WHERE p.Amount < (v.Rental_Rate_Per_Day * r.Total_Days);


/* ====================================================================
   SECTION 8: INNER JOIN
   ==================================================================== */

-- Customer name with rental details
SELECT c.Name, r.Rental_ID, r.Rental_Date, r.Return_Date
FROM Customers c
INNER JOIN Rentals r ON c.Customer_ID = r.Customer_ID;

-- Customer name and vehicle number
SELECT c.Name, v.Vehicle_Number
FROM Customers c
INNER JOIN Rentals r ON c.Customer_ID = r.Customer_ID
INNER JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID;

-- Customer name, vehicle brand and model
SELECT c.Name, v.Brand, v.Model
FROM Customers c
INNER JOIN Rentals r ON c.Customer_ID = r.Customer_ID
INNER JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID;

-- Rental date and return date with customer information
SELECT c.Name, c.Phone, r.Rental_Date, r.Return_Date
FROM Customers c
INNER JOIN Rentals r ON c.Customer_ID = r.Customer_ID;

-- Rental details along with payment information
SELECT r.Rental_ID, r.Rental_Date, p.Amount, p.Payment_Method
FROM Rentals r
INNER JOIN Payments p ON r.Rental_ID = p.Rental_ID;

-- Vehicle details along with maintenance information
SELECT v.Vehicle_Number, v.Brand, v.Model, m.Description, m.Cost
FROM Vehicles v
INNER JOIN Maintenance m ON v.Vehicle_ID = m.Vehicle_ID;


/* ====================================================================
   SECTION 9: MULTI-TABLE JOIN
   ==================================================================== */

-- Complete rental transaction report
SELECT
    c.Name            AS Customer_Name,
    c.Phone,
    v.Vehicle_Number,
    v.Brand,
    v.Model,
    r.Rental_Date,
    r.Return_Date,
    r.Total_Days,
    v.Rental_Rate_Per_Day AS Rental_Rate,
    p.Amount              AS Payment_Amount,
    p.Payment_Method
FROM Rentals r
JOIN Customers c ON r.Customer_ID = c.Customer_ID
JOIN Vehicles v  ON r.Vehicle_ID  = v.Vehicle_ID
JOIN Payments p  ON r.Rental_ID   = p.Rental_ID;


/* ====================================================================
   SECTION 10: LEFT JOIN
   ==================================================================== */

-- Customers who have never rented a vehicle
SELECT c.*
FROM Customers c
LEFT JOIN Rentals r ON c.Customer_ID = r.Customer_ID
WHERE r.Rental_ID IS NULL;

-- Vehicles that have never been rented
SELECT v.*
FROM Vehicles v
LEFT JOIN Rentals r ON v.Vehicle_ID = r.Vehicle_ID
WHERE r.Rental_ID IS NULL;

-- Vehicles that have never undergone maintenance
SELECT v.*
FROM Vehicles v
LEFT JOIN Maintenance m ON v.Vehicle_ID = m.Vehicle_ID
WHERE m.Maintenance_ID IS NULL;

-- All customers with rental count, including customers with zero rentals
SELECT c.Customer_ID, c.Name, COUNT(r.Rental_ID) AS Rental_Count
FROM Customers c
LEFT JOIN Rentals r ON c.Customer_ID = r.Customer_ID
GROUP BY c.Customer_ID, c.Name;


/* ====================================================================
   SECTION 11: SUBQUERIES
   ==================================================================== */

-- Vehicles whose rental rate is above the average rental rate
SELECT * FROM Vehicles
WHERE Rental_Rate_Per_Day > (SELECT AVG(Rental_Rate_Per_Day) FROM Vehicles);

-- Vehicle with the highest rental rate
SELECT * FROM Vehicles
WHERE Rental_Rate_Per_Day = (SELECT MAX(Rental_Rate_Per_Day) FROM Vehicles);

-- Customer with the highest payment
SELECT c.*
FROM Customers c
WHERE c.Customer_ID = (
    SELECT r.Customer_ID
    FROM Rentals r
    JOIN Payments p ON r.Rental_ID = p.Rental_ID
    ORDER BY p.Amount DESC
    LIMIT 1
);

-- Vehicles whose maintenance cost is above average
SELECT DISTINCT v.*
FROM Vehicles v
JOIN Maintenance m ON v.Vehicle_ID = m.Vehicle_ID
WHERE m.Cost > (SELECT AVG(Cost) FROM Maintenance);

-- Customers who have rented at least once
SELECT * FROM Customers
WHERE Customer_ID IN (SELECT DISTINCT Customer_ID FROM Rentals);

-- Vehicles that have never been rented (subquery version)
SELECT * FROM Vehicles
WHERE Vehicle_ID NOT IN (SELECT DISTINCT Vehicle_ID FROM Rentals);

-- Rentals where payment is above average
SELECT r.*
FROM Rentals r
JOIN Payments p ON r.Rental_ID = p.Rental_ID
WHERE p.Amount > (SELECT AVG(Amount) FROM Payments);


/* ====================================================================
   SECTION 12: WINDOW FUNCTIONS
   ==================================================================== */

-- Rank vehicles by rental rate, highest to lowest
SELECT Vehicle_ID, Brand, Model, Rental_Rate_Per_Day,
       RANK() OVER (ORDER BY Rental_Rate_Per_Day DESC) AS Rate_Rank
FROM Vehicles;

-- Rank customers based on total spending
SELECT c.Customer_ID, c.Name, SUM(p.Amount) AS Total_Spending,
       RANK() OVER (ORDER BY SUM(p.Amount) DESC) AS Spending_Rank
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
GROUP BY c.Customer_ID, c.Name;

-- Unique row number for each rental based on rental date
SELECT Rental_ID, Rental_Date,
       ROW_NUMBER() OVER (ORDER BY Rental_Date) AS Row_Num
FROM Rentals;

-- Top 3 highest-priced vehicles using DENSE_RANK()
SELECT * FROM (
    SELECT Vehicle_ID, Brand, Model, Rental_Rate_Per_Day,
           DENSE_RANK() OVER (ORDER BY Rental_Rate_Per_Day DESC) AS Price_Rank
    FROM Vehicles
) ranked
WHERE Price_Rank <= 3;

-- Each vehicle's rental rate along with the average rate of all vehicles
SELECT Vehicle_ID, Brand, Model, Rental_Rate_Per_Day,
       AVG(Rental_Rate_Per_Day) OVER () AS Overall_Avg_Rate
FROM Vehicles;

-- Each customer's total spending along with overall average customer spending
SELECT c.Customer_ID, c.Name, SUM(p.Amount) AS Total_Spending,
       AVG(SUM(p.Amount)) OVER () AS Overall_Avg_Spending
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
GROUP BY c.Customer_ID, c.Name;

-- Cumulative rental revenue based on rental date
SELECT r.Rental_ID, r.Rental_Date, p.Amount,
       SUM(p.Amount) OVER (ORDER BY r.Rental_Date) AS Cumulative_Revenue
FROM Rentals r
JOIN Payments p ON r.Rental_ID = p.Rental_ID;

-- Cumulative payment amount for each customer based on payment date
SELECT c.Customer_ID, c.Name, p.Payment_Date, p.Amount,
       SUM(p.Amount) OVER (PARTITION BY c.Customer_ID ORDER BY p.Payment_Date) AS Cumulative_Payment
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID;

-- Compare each rental payment with the previous rental payment using LAG()
SELECT Payment_ID, Payment_Date, Amount,
       LAG(Amount) OVER (ORDER BY Payment_Date) AS Previous_Payment_Amount
FROM Payments;

-- Next rental date for each customer using LEAD()
SELECT c.Customer_ID, c.Name, r.Rental_Date,
       LEAD(r.Rental_Date) OVER (PARTITION BY c.Customer_ID ORDER BY r.Rental_Date) AS Next_Rental_Date
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID;

-- Rank vehicles separately within each vehicle type based on rental rate
SELECT Vehicle_ID, Vehicle_Type, Brand, Model, Rental_Rate_Per_Day,
       RANK() OVER (PARTITION BY Vehicle_Type ORDER BY Rental_Rate_Per_Day DESC) AS Rank_In_Type
FROM Vehicles;

-- Rank customers separately based on their city and total spending
SELECT c.Address AS City, c.Name, SUM(p.Amount) AS Total_Spending,
       RANK() OVER (PARTITION BY c.Address ORDER BY SUM(p.Amount) DESC) AS Rank_In_City
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
GROUP BY c.Address, c.Customer_ID, c.Name;

-- Highest-revenue vehicle in each vehicle type
SELECT * FROM (
    SELECT v.Vehicle_Type, v.Vehicle_ID, v.Brand, v.Model,
           SUM(p.Amount) AS Vehicle_Revenue,
           RANK() OVER (PARTITION BY v.Vehicle_Type ORDER BY SUM(p.Amount) DESC) AS Revenue_Rank
    FROM Vehicles v
    JOIN Rentals r ON v.Vehicle_ID = r.Vehicle_ID
    JOIN Payments p ON r.Rental_ID = p.Rental_ID
    GROUP BY v.Vehicle_Type, v.Vehicle_ID, v.Brand, v.Model
) ranked
WHERE Revenue_Rank = 1;

-- Second-highest rental-rate vehicle in each vehicle category
SELECT * FROM (
    SELECT Vehicle_Type, Vehicle_ID, Brand, Model, Rental_Rate_Per_Day,
           DENSE_RANK() OVER (PARTITION BY Vehicle_Type ORDER BY Rental_Rate_Per_Day DESC) AS Rate_Rank
    FROM Vehicles
) ranked
WHERE Rate_Rank = 2;

-- Each vehicle's rental rate and difference from the average rate of its type
SELECT Vehicle_ID, Vehicle_Type, Rental_Rate_Per_Day,
       Rental_Rate_Per_Day - AVG(Rental_Rate_Per_Day) OVER (PARTITION BY Vehicle_Type) AS Diff_From_Type_Avg
FROM Vehicles;


/* ====================================================================
   SECTION 13: VIEWS
   ==================================================================== */

CREATE OR REPLACE VIEW Available_Vehicles AS
SELECT Vehicle_ID, Vehicle_Number, Vehicle_Type, Brand, Model, Rental_Rate_Per_Day
FROM Vehicles
WHERE Availability_Status = 'Available';

CREATE OR REPLACE VIEW Customer_Rental_Report AS
SELECT c.Customer_ID, c.Name, r.Rental_ID, v.Vehicle_Number, r.Rental_Date, r.Return_Date, r.Total_Days
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID;

CREATE OR REPLACE VIEW Vehicle_Maintenance_Report AS
SELECT v.Vehicle_ID, v.Vehicle_Number, v.Brand, v.Model, m.Maintenance_Date, m.Description, m.Cost
FROM Vehicles v
JOIN Maintenance m ON v.Vehicle_ID = m.Vehicle_ID;

CREATE OR REPLACE VIEW Customer_Spending_Report AS
SELECT c.Customer_ID, c.Name, SUM(p.Amount) AS Total_Spending
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
GROUP BY c.Customer_ID, c.Name;

-- Usage examples:
-- SELECT * FROM Available_Vehicles;
-- SELECT * FROM Customer_Rental_Report;
-- SELECT * FROM Vehicle_Maintenance_Report;
-- SELECT * FROM Customer_Spending_Report;


/* ====================================================================
   SECTION 14: UPDATE
   ==================================================================== */

-- Update a customer's phone number
UPDATE Customers SET Phone = '9999900001' WHERE Customer_ID = 1;

-- Update a customer's email
UPDATE Customers SET Email = 'rahul.sharma@gmail.com' WHERE Customer_ID = 1;

-- Update a vehicle's rental rate
UPDATE Vehicles SET Rental_Rate_Per_Day = 1900 WHERE Vehicle_ID = 1;

-- Change vehicle status from Available to Rented
UPDATE Vehicles SET Availability_Status = 'Rented' WHERE Vehicle_ID = 1;

-- Change vehicle status from Rented to Available
UPDATE Vehicles SET Availability_Status = 'Available' WHERE Vehicle_ID = 1;

-- Update payment status
UPDATE Payments SET Payment_Status = 'Pending' WHERE Payment_ID = 1;

-- Update maintenance status
UPDATE Maintenance SET Maintenance_Status = 'In Progress' WHERE Maintenance_ID = 1;


/* ====================================================================
   SECTION 15: DELETE
   ==================================================================== */

-- Delete a customer who has no rental history
-- (Customer_ID 21, "Farhan Ali", was seeded with zero rentals for this demo)
DELETE FROM Customers WHERE Customer_ID = 21;

-- Attempt to delete a customer who HAS rental records
-- This will FAIL with a foreign key constraint error (error 1451), because
-- Rentals.Customer_ID references Customers.Customer_ID and MySQL blocks the
-- delete by default (RESTRICT) to protect related transaction data.
-- DELETE FROM Customers WHERE Customer_ID = 1;

-- Delete an incorrect maintenance record
DELETE FROM Maintenance WHERE Maintenance_ID = 20;

-- Explanation of Foreign Key impact during deletion:
-- Because Rentals references Customers/Vehicles, and Payments references
-- Rentals, MySQL will not let you delete a parent row (e.g. a Customer or
-- Vehicle, or a Rental with a linked Payment) while child rows still point
-- to it. You must either delete the child rows first, or design the FK with
-- ON DELETE CASCADE / ON DELETE SET NULL if cascading deletes are desired.
-- This project intentionally leaves the default RESTRICT behavior so that
-- rental, payment, and maintenance history can never be silently orphaned.


/* ====================================================================
   SECTION 16: CONSTRAINTS
   ==================================================================== */
-- All constraints below are already implemented directly in the Section 1
-- table definitions above. Summary of what enforces each business rule:
--
-- PRIMARY KEY   -> Customer_ID, Vehicle_ID, Rental_ID, Payment_ID, Maintenance_ID
-- FOREIGN KEY   -> Rentals.Customer_ID -> Customers.Customer_ID
--                  Rentals.Vehicle_ID  -> Vehicles.Vehicle_ID
--                  Payments.Rental_ID  -> Rentals.Rental_ID
--                  Maintenance.Vehicle_ID -> Vehicles.Vehicle_ID
-- NOT NULL      -> Name, Phone, Driving_License_No, Vehicle_Number,
--                  Vehicle_Type, Brand, Model, Rental_Rate_Per_Day,
--                  Customer_ID/Vehicle_ID in Rentals, Rental_Date,
--                  Total_Days, Rental_ID in Payments, Payment_Date,
--                  Amount, Payment_Method, Vehicle_ID in Maintenance,
--                  Maintenance_Date, Cost
-- UNIQUE        -> Customer.Phone, Customer.Email, Driving_License_No,
--                  Vehicle_Number
-- DEFAULT       -> Vehicles.Availability_Status ('Available'),
--                  Rentals.Rental_Status ('Completed'),
--                  Payments.Payment_Status ('Paid'),
--                  Maintenance.Maintenance_Status ('Completed')
-- CHECK         -> Rental_Rate_Per_Day >= 0, Total_Days > 0, Amount >= 0,
--                  Cost >= 0, plus enum-style CHECKs on all status/method
--                  columns (Availability_Status, Rental_Status,
--                  Payment_Method, Payment_Status, Maintenance_Status)


/* ====================================================================
   SECTION 17: REAL-TIME BUSINESS SCENARIOS
   ==================================================================== */

-- Scenario 1: Vehicle Booking — find available vehicles under 2500/day
SELECT * FROM Vehicles
WHERE Availability_Status = 'Available' AND Rental_Rate_Per_Day < 2500;

-- Scenario 2: Customer History — full rental + payment history for a given Customer_ID (example: 1)
SELECT c.Name, r.Rental_ID, v.Vehicle_Number, r.Rental_Date, r.Return_Date, p.Amount, p.Payment_Method
FROM Customers c
JOIN Rentals r ON c.Customer_ID = r.Customer_ID
JOIN Vehicles v ON r.Vehicle_ID = v.Vehicle_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
WHERE c.Customer_ID = 1;

-- Scenario 3: Highest Revenue Vehicle
SELECT v.Vehicle_ID, v.Brand, v.Model, SUM(p.Amount) AS Vehicle_Revenue
FROM Vehicles v
JOIN Rentals r ON v.Vehicle_ID = r.Vehicle_ID
JOIN Payments p ON r.Rental_ID = p.Rental_ID
GROUP BY v.Vehicle_ID, v.Brand, v.Model
ORDER BY Vehicle_Revenue DESC
LIMIT 1;

-- Scenario 4: High Maintenance Vehicles (total cost exceeds 10000)
SELECT Vehicle_ID, SUM(Cost) AS Total_Maintenance_Cost
FROM Maintenance
GROUP BY Vehicle_ID
HAVING SUM(Cost) > 10000;

-- Scenario 5: Repeat Customers (more than one rental)
SELECT Customer_ID, COUNT(*) AS Rental_Count
FROM Rentals
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Scenario 6: Payment Analysis by method
SELECT Payment_Method, SUM(Amount) AS Total_Revenue
FROM Payments
GROUP BY Payment_Method;


/* ====================================================================
   SECTION 18: FINAL MANAGEMENT REPORT
   ==================================================================== */

SELECT
    (SELECT COUNT(*) FROM Customers)                                            AS Total_Customers,
    (SELECT COUNT(*) FROM Vehicles)                                             AS Total_Vehicles,
    (SELECT COUNT(*) FROM Vehicles WHERE Availability_Status = 'Available')     AS Available_Vehicles,
    (SELECT COUNT(*) FROM Vehicles WHERE Availability_Status = 'Rented')        AS Rented_Vehicles,
    (SELECT COUNT(*) FROM Vehicles WHERE Availability_Status = 'Maintenance')   AS Vehicles_Under_Maintenance,
    (SELECT SUM(Amount) FROM Payments)                                         AS Total_Revenue,
    (SELECT AVG(Amount) FROM Payments)                                         AS Average_Rental_Amount,
    (SELECT SUM(Cost) FROM Maintenance)                                        AS Total_Maintenance_Cost,
    (SELECT c.Name
       FROM Customers c
       JOIN Rentals r ON c.Customer_ID = r.Customer_ID
       JOIN Payments p ON r.Rental_ID = p.Rental_ID
       GROUP BY c.Customer_ID, c.Name
       ORDER BY SUM(p.Amount) DESC LIMIT 1)                                     AS Highest_Spending_Customer,
    (SELECT v.Model
       FROM Vehicles v
       JOIN Rentals r ON v.Vehicle_ID = r.Vehicle_ID
       GROUP BY v.Vehicle_ID, v.Model
       ORDER BY COUNT(*) DESC LIMIT 1)                                          AS Most_Rented_Vehicle,
    (SELECT Brand
       FROM Vehicles
       GROUP BY Brand
       ORDER BY COUNT(*) DESC LIMIT 1)                                          AS Most_Popular_Brand,
    (SELECT v.Model
       FROM Vehicles v
       JOIN Maintenance m ON v.Vehicle_ID = m.Vehicle_ID
       GROUP BY v.Vehicle_ID, v.Model
       ORDER BY SUM(m.Cost) DESC LIMIT 1)                                       AS Vehicle_With_Highest_Maintenance_Cost;


/* ====================================================================
   SECTION 19: TECHNICAL ROUND — QUICK ANSWER REFERENCE
   ==================================================================== */
-- Q: Why separate tables for Customers, Vehicles, Rentals, Payments, Maintenance?
-- A: Normalization — each table stores one entity, avoiding duplicate/redundant
--    data and keeping updates (e.g. a customer's phone number) isolated to one row.
--
-- Q: Relationship between Customers and Rentals?
-- A: One-to-many — one customer can have many rentals, enforced via
--    Rentals.Customer_ID as a foreign key to Customers.Customer_ID.
--
-- Q: Relationship between Vehicles and Rentals?
-- A: One-to-many — one vehicle can appear in many rentals over time, enforced
--    via Rentals.Vehicle_ID as a foreign key to Vehicles.Vehicle_ID.
--
-- Q: Why is Customer_ID a Foreign Key in Rentals? / Why Vehicle_ID?
-- A: To guarantee referential integrity — a rental can never reference a
--    customer or vehicle that doesn't actually exist in the parent table.
--
-- Q: WHERE vs HAVING?
-- A: WHERE filters individual rows before grouping/aggregation; HAVING
--    filters groups after GROUP BY/aggregation has been applied.
--
-- Q: DELETE vs TRUNCATE vs DROP?
-- A: DELETE removes rows (can use WHERE, is logged, triggers FK checks),
--    TRUNCATE removes all rows fast without per-row logging and resets
--    identity, DROP removes the entire table structure and data.
--
-- Q: INNER JOIN vs LEFT JOIN?
-- A: INNER JOIN returns only rows with matches in both tables; LEFT JOIN
--    returns all rows from the left table plus matches from the right,
--    with NULLs where there's no match.
--
-- Q: How to find customers who never rented?
-- A: LEFT JOIN Customers to Rentals and filter WHERE Rentals.Rental_ID IS NULL
--    (see Section 10), or use Customer_ID NOT IN (SELECT Customer_ID FROM Rentals).
--
-- Q: How to find the second-highest rental rate?
-- A: Use DENSE_RANK() OVER (ORDER BY Rental_Rate_Per_Day DESC) in a subquery
--    and filter WHERE rank = 2 (see Section 12).
--
-- Q: How to find the most rented vehicle / highest-spending customer?
-- A: GROUP BY the entity, aggregate (COUNT for rentals, SUM for spending),
--    ORDER BY that aggregate DESC, LIMIT 1 (see Sections 17-18).
--
-- Q: What is a subquery?
-- A: A query nested inside another query, used to supply a value, a row
--    set, or a filter condition to the outer query.
--
-- Q: What is a Window Function?
-- A: A function that performs a calculation across a set of rows related
--    to the current row (defined by OVER/PARTITION BY) without collapsing
--    them into a single output row, unlike a normal aggregate.
--
-- Q: RANK() vs DENSE_RANK() vs ROW_NUMBER()?
-- A: ROW_NUMBER() gives every row a unique sequential number. RANK() gives
--    tied rows the same rank but skips the next rank number(s). DENSE_RANK()
--    gives tied rows the same rank without skipping any rank numbers.
--
-- Q: Aggregate function vs window function?
-- A: An aggregate function (SUM, AVG, COUNT...) collapses many rows into
--    one result per group. A window function computes the same kind of
--    calculation but keeps every original row visible in the output.
--
-- Q: What is LAG() / LEAD() used for?
-- A: LAG() reads a value from a previous row in the window (e.g. comparing
--    this payment to the previous one). LEAD() reads a value from a
--    following row (e.g. finding a customer's next rental date).
--
-- Q: What is a View?
-- A: A saved, reusable virtual table defined by a SELECT query — querying
--    the view re-runs that query, so it always reflects live data without
--    duplicating storage.
--
-- Q: What is an Index?
-- A: A separate lookup structure (commonly a B-tree) built on one or more
--    columns that lets MySQL find matching rows without scanning the
--    whole table, speeding up WHERE/JOIN/ORDER BY at the cost of extra
--    storage and slightly slower writes.
--
-- Q: How would you optimize a slow query?
-- A: Check EXPLAIN, add indexes on columns used in WHERE/JOIN/ORDER BY,
--    avoid SELECT *, avoid functions on indexed columns in WHERE clauses,
--    and reduce unnecessary joins or subqueries.
--
-- Q: What is a transaction? What are COMMIT and ROLLBACK?
-- A: A transaction is a group of SQL statements executed as a single
--    all-or-nothing unit. COMMIT permanently saves all changes made in the
--    transaction; ROLLBACK undoes them, restoring the state before the
--    transaction began — used to keep data consistent if part of a
--    multi-step operation fails (e.g. a rental insert succeeding but its
--    matching payment insert failing).
