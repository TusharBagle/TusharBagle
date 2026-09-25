CREATE DATABASE Practical_Exam_Data_Analysis ;
USE Practical_Exam_Data_Analysis ;

DROP TABLE IF EXISTS Sales ;
DROP TABLE IF EXISTS Products ;

-- ===================================================================================================================================================================

-- SET A (Retail Sales)
CREATE TABLE Sales (
	Sales_ID  INTEGER  PRIMARY KEY ,
    Month  VARCHAR(50)  NOT NULL ,
    Product_ID  VARCHAR(50)  NOT NULL ,
    Region  VARCHAR(50)  NOT NULL ,
    Quantity  INTEGER  NOT NULL ,
    Unit_Price  REAL  NOT NULL ,
	
    FOREIGN KEY (Product_ID)
		REFERENCES Products(Product_ID)
) ;


CREATE TABLE Products (
    Product_id  VARCHAR(50)  PRIMARY KEY ,
    Product  VARCHAR(255)  NOT NULL ,
    Category  VARCHAR(100)  NOT NULL
) ;


INSERT INTO PRODUCTS 
	VALUES 
		('P1', 'Notebook', 'Stationery') ,
		('P2', 'Pen', 'Stationery') ,
		('P3', 'Mouse', 'Electronics') ,
		('P4', 'Keyboard', 'Electronics') ;


INSERT INTO Sales
	VALUES
		(1, 'Jan', 'P1', 'North', 12, 50) ,
		(2, 'Jan', 'P2', 'South', 20, 10) ,
		(3, 'Jan', 'P3', 'North', 3, 500) ,
		(4, 'Jan', 'P4', 'West', 2, 800) ,
		(5, 'Feb', 'P1', 'South', 15, 50) ,
		(6, 'Feb', 'P2', 'West', 30, 10) ,
		(7, 'Feb', 'P3', 'North', 4, 500) ,
		(8, 'Feb', 'P4', 'South', 3, 800) ,
		(9, 'Mar', 'P1', 'West', 10, 50) ,
		(10, 'Mar', 'P2', 'North', 25, 10) ,
		(11, 'Mar', 'P3', 'South', 5, 500) ,
		(12, 'Mar', 'P4', 'West', 4, 800) ;
        
        
        
SELECT
	*
FROM Sales ;   
    
SELECT
	*
FROM Products ;



-- 1. REVENUE BY CATEGORY
SELECT
	P.Category ,
    SUM(S.quantity * S.unit_price) AS Total_Revenue 
FROM Sales S
JOIN Products P
	ON S.Product_ID = P.Product_ID
GROUP BY P.Category
ORDER BY Total_Revenue DESC ;



-- 2. HIGH REVENUE PRODUCTS
SELECT
	P.Category ,
    SUM(S.quantity * S.unit_price) AS Total_Revenue 
FROM Sales S
JOIN Products P
	ON S.Product_ID = P.Product_ID
GROUP BY P.Category
HAVING Total_Revenue > 3000
ORDER BY Total_Revenue DESC ;



-- 3. TOP 2 REGION BY REVENUE
SELECT
	Region ,
    SUM(S.quantity * S.unit_price) AS Total_Revenue 
FROM Sales S
GROUP BY Region 
ORDER BY Total_Revenue DESC,Region ASC
LIMIT 2 ;


-- 4. DATA INTEGRITY check
SELECT
	P.Product_ID ,
    P.Product ,
    COUNT(S.Sales_ID) AS Matching_Sales 
FROM Products P
JOIN Sales S
	ON P.Product_ID = S.Product_ID
GROUP BY P.Product_ID , P.Product
ORDER BY P.Product_ID ;




-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================




-- SET B (Food Delivery)
CREATE TABLE restaurants (
    restaurant_id VARCHAR(10) PRIMARY KEY,
    restaurant VARCHAR(100),
    cuisine VARCHAR(50)
);


CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    month VARCHAR(10),
    restaurant_id VARCHAR(10),
    zone VARCHAR(50),
    order_value DECIMAL(10,2),
    delivery_minutes INT,

    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);


INSERT INTO restaurants
(restaurant_id, restaurant, cuisine)
VALUES
('R1', 'SpiceHouse', 'Indian'),
('R2', 'PizzaPoint', 'Italian'),
('R3', 'WokBox', 'Asian'),
('R4', 'CurryCorner', 'Indian');



INSERT INTO deliveries
(delivery_id, month, restaurant_id, zone, order_value, delivery_minutes)
VALUES
(1, 'Jan', 'R1', 'East', 450, 25),
(2, 'Jan', 'R2', 'West', 600, 40),
(3, 'Jan', 'R3', 'East', 350, 30),
(4, 'Jan', 'R4', 'Central', 500, 50),
(5, 'Feb', 'R1', 'West', 550, 35),
(6, 'Feb', 'R2', 'Central', 700, 28),
(7, 'Feb', 'R3', 'East', 400, 45),
(8, 'Feb', 'R4', 'West', 650, 32),
(9, 'Mar', 'R1', 'Central', 600, 20),
(10, 'Mar', 'R2', 'East', 800, 48),
(11, 'Mar', 'R3', 'West', 450, 26),
(12, 'Mar', 'R4', 'Central', 700, 38);




-- 1. Average delivery time by cuisine
SELECT
	R.cuisine ,
    ROUND(AVG(D.delivery_minutes) , 2) AS AVG_Delivery_Time
FROM deliveries D
JOIN restaurants R
	ON R.restaurant_id = D.restaurant_id
GROUP BY R.cuisine
ORDER BY AVG_Delivery_Time DESC ;



-- 2. Late Performing Restaurants
-- Which restaurants have an average delivery time above 35 minutes?
SELECT
    r.restaurant_id,
    r.restaurant,
    ROUND(AVG(d.delivery_minutes), 2)
        AS avg_delivery_minutes
FROM deliveries d
JOIN restaurants r
    ON d.restaurant_id = r.restaurant_id
GROUP BY
    r.restaurant_id,
    r.restaurant
HAVING AVG(d.delivery_minutes) > 35
ORDER BY avg_delivery_minutes DESC;



-- 3. Top two zones by late-delivery count
SELECT
    zone,
    COUNT(*) AS late_delivery_count
FROM deliveries
WHERE delivery_minutes > 35
GROUP BY zone
ORDER BY
    late_delivery_count DESC,
    zone ASC 
LIMIT 2 ;



-- 4. SQL Diagnostic Query
SELECT
    r.restaurant_id,
    r.restaurant
FROM restaurants r
LEFT JOIN deliveries d
    ON r.restaurant_id = d.restaurant_id
WHERE d.restaurant_id IS NULL;




-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================




-- SET C (Traning Analysis)
DROP TABLE IF EXISTS assessments;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses (
    course_id VARCHAR(50) PRIMARY KEY,
    course VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL
);

CREATE TABLE assessments (
    assessment_id INTEGER PRIMARY KEY,
    month TEXT NOT NULL,
    course_id VARCHAR(50) NOT NULL,
    batch TEXT NOT NULL,
    score REAL NOT NULL,
    attendance_pct REAL NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


INSERT INTO courses (course_id, course, department)
VALUES
('C1', 'Excel', 'Business'),
('C2', 'PowerBI', 'Business'),
('C3', 'SQL', 'Technology'),
('C4', 'Python', 'Technology');


INSERT INTO assessments
(assessment_id, month, course_id, batch, score, attendance_pct)
VALUES
(1, 'Jan', 'C1', 'Morning', 72, 90),
(2, 'Jan', 'C2', 'Evening', 45, 70),
(3, 'Jan', 'C3', 'Morning', 65, 85),
(4, 'Jan', 'C4', 'Weekend', 38, 60),
(5, 'Feb', 'C1', 'Evening', 80, 95),
(6, 'Feb', 'C2', 'Weekend', 55, 80),
(7, 'Feb', 'C3', 'Morning', 48, 75),
(8, 'Feb', 'C4', 'Evening', 68, 88),
(9, 'Mar', 'C1', 'Weekend', 90, 98),
(10, 'Mar', 'C2', 'Morning', 60, 82),
(11, 'Mar', 'C3', 'Evening', 75, 92),
(12, 'Mar', 'C4', 'Weekend', 42, 65);



-- 1. Average Score By Department
SELECT
	C.department , 
    AVG(score) AS AVG_Score
FROM assessments A
JOIN courses C
	ON C.course_id = A.course_id
GROUP BY C.department 
ORDER BY AVG_Score DESC ;


-- 2. Unperforming Courses
SELECT
	C.course ,
    ROUND(AVG(score) , 2) AS AVG_Score
FROM assessments A
JOIN courses C
	ON C.course_id = A.course_id
GROUP BY C.course
HAVING AVG_Score < 60 ;


-- 3. Top 2 Batches by AVG. Score
SELECT
	A.batch ,
    ROUND(AVG(score) , 2) AS AVG_Score
FROM assessments A
JOIN courses C
	ON C.course_id = A.course_id
GROUP BY A.batch
ORDER BY AVG_Score DESC 
LIMIT 2 ;


-- 4. diagnostic Query
SELECT
	C.course_id ,
    C.course ,
	COUNT(A.assessment_id) AS Assesments_Count
FROM assessments A
LEFT JOIN courses C
	ON C.course_id = A.course_id
GROUP BY C.course_id , C.course ;




-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================




-- SET D (Inventory Planing)
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS items;

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL
);

CREATE TABLE inventory (
    record_id INTEGER PRIMARY KEY,
    month VARCHAR(50) NOT NULL,
    item_id VARCHAR(50) NOT NULL,
    warehouse VARCHAR(50) NOT NULL,
    stock REAL NOT NULL,
    reorder_level REAL NOT NULL,
    FOREIGN KEY (item_id)
        REFERENCES items(item_id)
);


INSERT INTO items
(item_id, item, category)
VALUES
('I1', 'Paper', 'Office'),
('I2', 'Ink', 'Office'),
('I3', 'Cable', 'Hardware'),
('I4', 'Adapter', 'Hardware');


INSERT INTO inventory
(record_id, month, item_id, warehouse, stock, reorder_level)
VALUES
(1, 'Jan', 'I1', 'North', 80, 50),
(2, 'Jan', 'I2', 'South', 15, 20),
(3, 'Jan', 'I3', 'North', 25, 30),
(4, 'Jan', 'I4', 'West', 12, 15),
(5, 'Feb', 'I1', 'South', 40, 50),
(6, 'Feb', 'I2', 'West', 25, 20),
(7, 'Feb', 'I3', 'North', 18, 30),
(8, 'Feb', 'I4', 'South', 20, 15),
(9, 'Mar', 'I1', 'West', 30, 50),
(10, 'Mar', 'I2', 'North', 10, 20),
(11, 'Mar', 'I3', 'South', 35, 30),
(12, 'Mar', 'I4', 'West', 8, 15);




-- 1. Total shortage_units by category
SELECT
	itm.category ,
	SUM(
		CASE
			WHEN inv.reorder_level > inv.stock THEN inv.reorder_level - inv.stock
            ELSE 0
		END 
    ) AS Total_shortage_Units
FROM inventory inv
JOIN items itm
	ON inv.item_id = itm.item_id
GROUP BY itm.category
ORDER BY Total_shortage_Units DESC ;



-- 2. tems with significant shortfall
SELECT
	itm.item ,
	SUM(
		CASE
			WHEN inv.reorder_level > inv.stock THEN inv.reorder_level - inv.stock
            ELSE 0
		END 
    ) AS Total_shortage_Units
FROM inventory inv
JOIN items itm
	ON inv.item_id = itm.item_id
GROUP BY itm.item , itm.item_id
HAVING Total_shortage_Units > 10
ORDER BY Total_shortage_Units DESC ;


-- 3. Top two warehouses by shortage
SELECT
	 inv.warehouse ,
	SUM(
		CASE
			WHEN inv.reorder_level > inv.stock THEN inv.reorder_level - inv.stock
            ELSE 0
		END 
    ) AS Total_shortage_Units
FROM inventory inv
JOIN items itm
	ON inv.item_id = itm.item_id
GROUP BY inv.warehouse
ORDER BY Total_shortage_Units DESC
LIMIT 2 ;



-- 4. diagnostic query
SELECT
    itm.item_id ,
	itm.item ,
    COUNT(inv.record_id) AS Inventory_Rows
FROM items itm
LEFT JOIN inventory inv
	ON inv.item_id = itm.item_id
GROUP BY itm.item_id , itm.item ;




-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================




-- SET E (Customer Support)
CREATE TABLE teams (
    team_id VARCHAR(50) PRIMARY KEY,
    team VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL
);


CREATE TABLE tickets (
    ticket_id INTEGER PRIMARY KEY,
    month VARCHAR(50) NOT NULL,
    team_id VARCHAR(50) NOT NULL,
    channel VARCHAR(50) NOT NULL,
    resolution_hours REAL NOT NULL,
    satisfaction REAL NOT NULL,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);



INSERT INTO teams
(team_id, team, department)
VALUES
('T1', 'AccountCare', 'Service'),
('T2', 'BillingHelp', 'Service'),
('T3', 'AppSupport', 'Technical'),
('T4', 'DeviceHelp', 'Technical');


INSERT INTO tickets
(ticket_id, month, team_id, channel, resolution_hours, satisfaction)
VALUES
(1, 'Jan', 'T1', 'Email', 12, 4),
(2, 'Jan', 'T2', 'Chat', 28, 3),
(3, 'Jan', 'T3', 'Phone', 36, 2),
(4, 'Jan', 'T4', 'Email', 20, 4),
(5, 'Feb', 'T1', 'Chat', 8, 5),
(6, 'Feb', 'T2', 'Phone', 30, 3),
(7, 'Feb', 'T3', 'Email', 18, 4),
(8, 'Feb', 'T4', 'Chat', 40, 2),
(9, 'Mar', 'T1', 'Phone', 16, 4),
(10, 'Mar', 'T2', 'Email', 22, 4),
(11, 'Mar', 'T3', 'Chat', 32, 3),
(12, 'Mar', 'T4', 'Phone', 24, 5);



-- 1. Average resolution by department
SELECT
	trm.department , 
    ROUND(AVG(resolution_hours) , 2) AS AVG_Resolution_Hours
FROM tickets tct
JOIN teams trm
	ON trm.team_id = tct.team_id
GROUP BY trm.department
ORDER BY AVG_Resolution_Hours DESC ;


-- 2. Teams breaching SLA
SELECT
	trm.team , 
    ROUND(AVG(resolution_hours) , 2) AS AVG_Resolution_Hours
FROM tickets tct
JOIN teams trm
	ON trm.team_id = tct.team_id
GROUP BY trm.team
HAVING AVG_Resolution_Hours > 24
ORDER BY AVG_Resolution_Hours DESC ;


-- 3. Top two channels by breach count
SELECT
	channel ,
    COUNT(*)  AS Breach_Count
FROM tickets
WHERE resolution_hours > 24
GROUP BY channel
ORDER BY Breach_Count DESC 
LIMIT 2 ;


-- 4. SQL Diagnostic
SELECT
	trm.team_id , 
    trm.team ,
    COUNT(tct.ticket_id) AS Ticket_Count
FROM teams trm
LEFT JOIN tickets tct
	ON trm.team_id = tct.team_id
GROUP BY trm.team_id , trm.team ;




-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================
-- ===================================================================================================================================================================