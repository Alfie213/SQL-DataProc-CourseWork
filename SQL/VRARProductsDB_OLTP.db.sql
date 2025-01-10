BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Developers";
CREATE TABLE Developers (
    DeveloperID INTEGER PRIMARY KEY,
    DeveloperName TEXT,
    Country TEXT,
    FoundedYear INTEGER,
    StartDate DATE,
    EndDate DATE,
    IsActive INTEGER
);
DROP TABLE IF EXISTS "DeviceFeatures";
CREATE TABLE DeviceFeatures (
    FeatureID INT PRIMARY KEY,
    FeatureDescription VARCHAR(255),
    DeviceID INT,
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);
DROP TABLE IF EXISTS "Devices";
CREATE TABLE Devices (
    DeviceID INT PRIMARY KEY,
    DeviceName VARCHAR(100),
    Manufacturer VARCHAR(100)
);
DROP TABLE IF EXISTS "Feedbacks";
CREATE TABLE Feedbacks (
    FeedbackID INT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    FeedbackText TEXT,
    Rating INT,
    FeedbackDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
DROP TABLE IF EXISTS "Orders";
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    OrderDate TEXT,
    Quantity INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
DROP TABLE IF EXISTS "Products";
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductType VARCHAR(50),
    DeveloperID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (DeveloperID) REFERENCES Developers(DeveloperID)
);
DROP TABLE IF EXISTS "Subscriptions";
CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    UserID INT,
    SubscriptionType VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
DROP TABLE IF EXISTS "Users";
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    Email VARCHAR(100),
    DateOfBirth DATE
);
INSERT INTO "Developers" ("DeveloperID","DeveloperName","Country","FoundedYear","StartDate","EndDate","IsActive") VALUES (101,'TechCo','USA',2010,'2010-01-01','NULL','TRUE'),
 (102,'InnovateCorp','UK',2012,'2012-01-01','2022-12-31','FALSE'),
 (103,'FutureGizmos','Canada',2015,'2015-01-01','NULL','TRUE'),
 (104,'VisionTech','Germany',2013,'2013-01-01','2021-06-30','FALSE'),
 (105,'ImmersiveInc','USA',2016,'2016-01-01','NULL','TRUE'),
 (106,'SmartWear','Sweden',2018,'2018-01-01','NULL','TRUE'),
 (107,'TechLabs','Australia',2014,'2014-01-01','NULL','TRUE'),
 (108,'HyperVision','Japan',2020,'2020-01-01','NULL','TRUE'),
 (109,'NextGenVR','France',2017,'2017-01-01','NULL','TRUE'),
 (110,'WorldVR','South Korea',2019,'2019-01-01','2023-01-01','FALSE'),
 (111,'GloveTech','USA',2021,'2021-01-01','NULL','TRUE'),
 (112,'RealTimeAR','India',2022,'2022-01-01','NULL','TRUE'),
 (113,'MetaWorld','China',2021,'2021-01-01','NULL','TRUE'),
 (114,'VRMasters','Spain',2018,'2018-01-01','2022-12-31','FALSE'),
 (115,'HoloGear','Italy',2017,'2017-01-01','NULL','TRUE'),
 (116,'ARWorks','Netherlands',2015,'2015-01-01','NULL','TRUE'),
 (117,'PixelPlay','USA',2020,'2020-01-01','NULL','TRUE'),
 (118,'VisionaryTech','Canada',2019,'2019-01-01','NULL','TRUE'),
 (119,'QuantumVR','UK',2021,'2021-01-01','NULL','TRUE'),
 (120,'SmartVision','Denmark',2022,'2022-01-01','NULL','TRUE');
INSERT INTO "DeviceFeatures" ("FeatureID","FeatureDescription","DeviceID") VALUES (1,'Full-HD display',1),
 (2,'Gesture control',2),
 (3,'Wireless connectivity',3),
 (4,'Augmented reality',4),
 (5,'Immersive haptics',5),
 (6,'Heart rate monitor',6),
 (7,'Voice control',7),
 (8,'Noise-cancellation',8),
 (9,'Motion tracking',9),
 (10,'3D holograms',10),
 (11,'Customizable fit',11),
 (12,'Eye tracking',12),
 (13,'Virtual reality',13),
 (14,'360-degree sound',14),
 (15,'Body tracking',15),
 (16,'Portable design',16),
 (17,'Adjustable head straps',17),
 (18,'Interactive touchpad',18),
 (19,'HD audio',19),
 (20,'Flexible sensors',20);
INSERT INTO "Devices" ("DeviceID","DeviceName","Manufacturer") VALUES (1,'VR Headset','TechCo'),
 (2,'AR Glasses','InnovateCorp'),
 (3,'VR Gloves','FutureGizmos'),
 (4,'AR Goggles','VisionTech'),
 (5,'VR Suit','ImmersiveInc'),
 (6,'AR Smart Watch','SmartWear'),
 (7,'VR Holo-Glasses','TechCo'),
 (8,'AR Headset','InnovateCorp'),
 (9,'VR Motion Controller','FutureGizmos'),
 (10,'AR Smart Glasses','VisionTech'),
 (11,'VR Enhanced Gloves','ImmersiveInc'),
 (12,'AR Headset Plus','SmartWear'),
 (13,'VR Gamepad','TechCo'),
 (14,'AR Smart Headphones','InnovateCorp'),
 (15,'VR Full-Body Suit','FutureGizmos'),
 (16,'AR Portable Projector','VisionTech'),
 (17,'VR Immersive Chair','ImmersiveInc'),
 (18,'AR Interactive Glasses','SmartWear'),
 (19,'VR Ultra Headset','TechCo'),
 (20,'AR Smart Ring','InnovateCorp');
INSERT INTO "Feedbacks" ("FeedbackID","UserID","ProductID","FeedbackText","Rating","FeedbackDate") VALUES (1,1,3,'Great product for immersion!',5,'2023-01-20'),
 (2,2,7,'Good fun, but a bit repetitive',4,'2023-03-12'),
 (3,3,12,'The app was useful for travel planning',5,'2023-06-10'),
 (4,4,8,'Not bad, could use more exercises',3,'2023-07-25'),
 (5,5,5,'VR Headset is fantastic, highly recommended',5,'2023-09-10'),
 (6,6,14,'The AR goggles were a bit bulky',3,'2023-12-10'),
 (7,7,19,'Scary but amazing, love the atmosphere',5,'2023-11-05'),
 (8,8,20,'Convenient for online shopping',4,'2023-08-25'),
 (9,9,2,'AR glasses were underwhelming',2,'2023-05-20'),
 (10,10,9,'Very comfortable, I use it all the time',5,'2023-10-28'),
 (11,11,11,'Awesome racing experience',4,'2023-04-15'),
 (12,12,6,'Couldn�t get them to fit well',2,'2023-02-15'),
 (13,13,4,'Helped me navigate new cities easily',5,'2023-09-30'),
 (14,14,17,'Great product, really immersive',5,'2023-06-25'),
 (15,15,18,'Works well, but could be thinner',4,'2023-01-10'),
 (16,16,1,'Great VR immersion, but heavy after a while',4,'2023-07-15'),
 (17,17,3,'The game was addictive',5,'2023-11-18'),
 (18,18,13,'Very comfortable to wear for long sessions',5,'2023-12-05'),
 (19,19,16,'The educational app is good but lacks variety',3,'2023-03-25'),
 (20,20,10,'Very useful for virtual meetings',4,'2023-08-12'),
 (21,1,3,'Absolutely loved it! Great for gaming',5,'2024-02-01'),
 (22,2,7,'Pretty good, but it can get a little boring',3,'2024-04-10'),
 (23,3,12,'Useful for solo travelers, but lacks features for group planning',4,'2024-07-14'),
 (24,4,8,'Not enough content for my needs',2,'2024-05-02'),
 (25,5,5,'Still my favorite, can''t recommend enough!',5,'2024-10-30'),
 (26,6,14,'Good for short periods, but uncomfortable for long use',3,'2024-01-12'),
 (27,7,19,'Love the thrill, would recommend!',5,'2024-06-03'),
 (28,8,20,'Great for shopping, but slow response at times',3,'2024-09-22'),
 (29,9,2,'Too expensive for what it offers',1,'2024-04-08'),
 (30,10,9,'Still amazing after all this time!',5,'2024-12-20'),
 (31,11,11,'Really fun, but wish there were more cars to choose from',4,'2024-06-30'),
 (32,12,6,'Too uncomfortable, couldn''t wear them for long',2,'2024-03-05'),
 (33,13,4,'Perfect for my travels, easy to use',5,'2024-11-12'),
 (34,14,17,'Love it! Best product for immersive experiences',5,'2024-02-18'),
 (35,15,18,'Good, but the fit could be better',3,'2024-08-30'),
 (36,16,1,'Comfortable for short sessions, but heavy for long ones',4,'2024-05-25'),
 (37,17,3,'Obsessed with it, highly recommend!',5,'2024-09-02'),
 (38,18,13,'Perfect for long work sessions, very comfortable',5,'2024-10-15'),
 (39,19,16,'Good for learning, but too basic',3,'2024-07-10'),
 (40,20,10,'Great for virtual meetings, still love it',4,'2024-11-10'),
 (41,1,3,'One of the best purchases I�ve made!',5,'2024-08-03'),
 (42,2,7,'Not bad, but could use some improvements',3,'2024-06-14'),
 (43,3,12,'Very helpful, would recommend for anyone traveling solo',5,'2024-02-20'),
 (44,4,8,'Disappointing experience, not enough features',2,'2024-04-01'),
 (45,5,5,'Best headset ever! My go-to for gaming',5,'2024-07-01'),
 (46,6,14,'Very bulky, uncomfortable for long sessions',3,'2024-11-17'),
 (47,7,19,'Loved the experience, it was thrilling!',5,'2024-10-05'),
 (48,8,20,'Good for shopping but glitchy at times',3,'2024-09-18'),
 (49,9,2,'Not worth the price, the quality was lacking',1,'2024-06-12'),
 (50,10,9,'Use it daily for work, very comfortable',5,'2024-05-02'),
 (51,11,11,'Great racing experience, but wish it was more challenging',4,'2024-02-22'),
 (52,12,6,'Not as advertised, disappointing overall',2,'2024-01-25'),
 (53,13,4,'Great for navigating unfamiliar cities',5,'2024-03-30'),
 (54,14,17,'Good immersion, but could use more variety',3,'2024-07-22'),
 (55,15,18,'Comfortable, but too bulky for my taste',4,'2024-09-05'),
 (56,16,1,'Great immersion, but felt heavy after a while',4,'2024-06-18'),
 (57,17,3,'Addictive, can�t put it down!',5,'2024-05-10'),
 (58,18,13,'Perfect for extended use, would recommend!',5,'2024-07-15'),
 (59,19,16,'Useful but too basic for advanced users',3,'2024-08-28'),
 (60,20,10,'Very useful, but could be improved with more features',4,'2024-10-08'),
 (61,1,3,'Perfect for long gaming sessions, great value',5,'2024-04-10'),
 (62,2,7,'Not a fan, too repetitive',2,'2024-05-18'),
 (63,3,12,'Good for solo trips, but could use group features',4,'2024-03-22'),
 (64,4,8,'Not great, didn�t meet expectations',2,'2024-07-09'),
 (65,5,5,'Absolutely love it!',5,'2024-06-27'),
 (66,6,14,'Good for short-term use, but not for extended periods',3,'5/15/202en'),
 (67,7,19,'Amazing experience, would do it again!',5,'2024-12-12'),
 (68,8,20,'Great product, but could be more responsive',4,'2024-10-17'),
 (69,9,2,'Not as good as expected, disappointed',2,'2024-08-22'),
 (70,10,9,'Excellent quality and very comfortable',5,'2024-01-30'),
 (71,11,11,'Loved it! Wish there were more cars to choose from',4,'2024-06-28'),
 (72,12,6,'Very uncomfortable, couldn''t use it for long',2,'2024-04-12'),
 (73,13,4,'Great product, helped me a lot while traveling',5,'2024-01-15'),
 (74,14,17,'Good product, but needs better customization options',3,'2024-03-08'),
 (75,15,18,'Comfortable but heavy for long use',4,'2024-08-19'),
 (76,16,1,'Great product, but weight is a concern for long sessions',4,'2024-02-28'),
 (77,17,3,'The most addictive game I''ve played in a while',5,'2024-04-07'),
 (78,18,13,'Perfect for gaming and long work sessions',5,'2024-05-28'),
 (79,19,16,'Good for beginners, but lacks advanced features',3,'2024-10-11'),
 (80,20,10,'Still the best headset for meetings, love it',4,'2024-12-09'),
 (81,1,3,'Excellent product, highly recommended',5,'2024-07-19'),
 (82,2,7,'Decent, but can get repetitive',3,'2024-09-30'),
 (83,3,12,'Great for personal use, not so much for groups',4,'2024-02-14'),
 (84,4,8,'Underwhelming, didn''t meet expectations',2,'2024-03-29'),
 (85,5,5,'Fantastic headset, my favorite so far!',5,'2024-05-11'),
 (86,6,14,'Good for short uses, but heavy for long sessions',3,'2024-06-08'),
 (87,7,19,'Thrilling experience, would recommend',5,'2024-08-17'),
 (88,8,20,'Very useful for shopping, but needs better search functionality',3,'2024-11-04'),
 (89,9,2,'Quality was disappointing, wouldn''t buy again',1,'2024-07-03'),
 (90,10,9,'Comfortable, use it daily for work',5,'2024-04-20'),
 (91,11,11,'Great experience, but could use more challenges',4,'2024-02-02'),
 (92,12,6,'Not comfortable at all, can''t wear it for long',2,'2024-06-22'),
 (93,13,4,'Helped me navigate the city, would definitely recommend',5,'2024-08-10'),
 (94,14,17,'Good immersion, but could be improved with more content',4,'2024-09-28'),
 (95,15,18,'Very comfortable, but bulky for extended use',4,'2024-10-19'),
 (96,16,1,'Great product, but a bit too heavy for long sessions',4,'2024-05-06'),
 (97,17,3,'Can''t stop playing! So addictive',5,'2024-01-23'),
 (98,18,13,'Perfect for both gaming and work, would recommend',5,'2024-12-14'),
 (99,19,16,'Good app for beginners, but lacks complexity',3,'2024-11-06'),
 (100,20,10,'Very comfortable and functional, still my favorite headset',5,'2024-09-14');
INSERT INTO "Orders" ("OrderID","UserID","ProductID","OrderDate","Quantity") VALUES (1,1,3,'2023-01-15',2),
 (2,2,7,'2023-03-10',1),
 (3,3,12,'2023-06-05',3),
 (4,4,8,'2023-07-20',1),
 (5,5,5,'2023-09-01',2),
 (6,6,14,'2023-12-15',1),
 (7,7,19,'2023-11-02',4),
 (8,8,20,'2023-08-17',1),
 (9,9,2,'2023-05-06',3),
 (10,10,9,'2023-10-22',2),
 (11,11,11,'2023-04-12',1),
 (12,12,6,'2023-02-10',5),
 (13,13,4,'2023-09-25',2),
 (14,14,17,'2023-06-30',3),
 (15,15,18,'2023-01-28',1),
 (16,16,1,'2023-07-10',2),
 (17,17,3,'2023-11-15',1),
 (18,18,13,'2023-12-03',2),
 (19,19,16,'2023-03-21',1),
 (20,20,10,'2023-08-11',4),
 (21,1,3,'2024-02-15',1),
 (22,2,7,'2024-03-10',3),
 (23,3,12,'2024-05-01',2),
 (24,4,8,'2024-01-15',1),
 (25,5,5,'2024-09-01',3),
 (26,6,14,'2024-06-10',2),
 (27,7,19,'2024-12-01',1),
 (28,8,20,'2024-07-15',4),
 (29,9,2,'2024-10-10',2),
 (30,10,9,'2024-11-22',3),
 (31,11,11,'2024-04-01',2),
 (32,12,6,'2024-01-05',3),
 (33,13,4,'2024-05-10',1),
 (34,14,17,'2024-08-01',2),
 (35,15,18,'2024-02-20',4),
 (36,16,1,'2024-11-01',1),
 (37,17,3,'2024-12-10',3),
 (38,18,13,'2024-07-05',1),
 (39,19,16,'2024-03-25',2),
 (40,20,10,'2024-09-18',5),
 (41,2,7,'2024-12-22',1),
 (42,5,5,'2024-06-10',3),
 (43,6,14,'2024-02-14',4),
 (44,1,3,'2024-04-05',2),
 (45,7,19,'2024-01-02',1),
 (46,8,20,'2024-08-05',2),
 (47,9,2,'2024-09-12',1),
 (48,10,9,'2024-03-28',3),
 (49,11,11,'2024-05-17',1),
 (50,12,6,'2024-03-10',4),
 (51,13,4,'2024-02-28',2),
 (52,14,17,'2024-11-18',1),
 (53,15,18,'2024-05-11',2),
 (54,16,1,'2024-07-20',3),
 (55,17,3,'2024-08-22',4),
 (56,18,13,'2024-04-30',3),
 (57,19,16,'2024-06-15',2),
 (58,20,10,'2024-10-25',1),
 (59,1,3,'2024-08-10',3),
 (60,2,7,'2024-11-01',1),
 (61,3,12,'2024-03-30',2),
 (62,4,8,'2024-05-25',4),
 (63,5,5,'2024-12-01',3),
 (64,6,14,'2024-09-10',2),
 (65,7,19,'2024-10-05',5),
 (66,8,20,'2024-06-25',1),
 (67,9,2,'2024-04-15',3),
 (68,10,9,'2024-12-03',2),
 (69,11,11,'2024-09-18',1),
 (70,12,6,'2024-11-22',2),
 (71,13,4,'2024-01-10',1),
 (72,14,17,'2024-04-05',2),
 (73,15,18,'2024-09-15',3),
 (74,16,1,'2024-12-28',1),
 (75,17,3,'2024-02-20',3),
 (76,18,13,'2024-10-12',2),
 (77,19,16,'2024-07-30',4),
 (78,20,10,'2024-05-20',2),
 (79,1,3,'2024-06-15',4),
 (80,2,7,'2024-09-28',1),
 (81,3,12,'2024-02-05',1),
 (82,4,8,'2024-03-12',3),
 (83,5,5,'2024-04-10',2),
 (84,6,14,'2024-05-21',4),
 (85,7,19,'2024-01-30',2),
 (86,8,20,'2024-12-14',5),
 (87,9,2,'2024-08-18',2),
 (88,10,9,'2024-07-02',3),
 (89,11,11,'2024-10-11',1),
 (90,12,6,'2024-12-01',2),
 (91,13,4,'2024-06-12',3),
 (92,14,17,'2024-09-10',1),
 (93,15,18,'2024-10-17',2),
 (94,16,1,'2024-03-18',4),
 (95,17,3,'2024-06-01',1),
 (96,18,13,'2024-01-12',3),
 (97,19,16,'2024-08-25',5),
 (98,20,10,'2024-11-06',1),
 (99,2,7,'2024-02-10',2),
 (100,5,5,'2024-07-25',3);
INSERT INTO "Products" ("ProductID","ProductName","ProductType","DeveloperID","Price") VALUES (1,'VR Headset','Gadget',101,299.99),
 (2,'AR Glasses','Gadget',102,349.99),
 (3,'VR Game: Adventure','Software',103,59.99),
 (4,'AR App: Navigation','Software',104,9.99),
 (5,'VR Headset Pro','Gadget',105,499.99),
 (6,'AR Gloves','Gadget',106,149.99),
 (7,'VR Game: Battle Arena','Software',107,69.99),
 (8,'AR App: Fitness','Software',108,14.99),
 (9,'VR Glasses','Gadget',109,399.99),
 (10,'AR Headset','Gadget',110,429.99),
 (11,'VR Game: Racing','Software',111,39.99),
 (12,'AR App: Travel Guide','Software',112,4.99),
 (13,'VR Suit','Gadget',113,699.99),
 (14,'AR Goggles','Gadget',114,279.99),
 (15,'VR Game: Puzzle Master','Software',115,19.99),
 (16,'AR App: Education','Software',116,24.99),
 (17,'VR Holo-Glasses','Gadget',117,649.99),
 (18,'AR Smart Watch','Gadget',118,199.99),
 (19,'VR Game: Horror Escape','Software',119,49.99),
 (20,'AR App: Shopping','Software',120,12.99);
INSERT INTO "Subscriptions" ("SubscriptionID","UserID","SubscriptionType","StartDate","EndDate") VALUES (1,1,'Premium','2023-01-15','2024-01-15'),
 (2,1,'Free','2024-02-15','2024-05-15'),
 (3,1,'Premium','2024-06-01','2025-06-01'),
 (4,2,'Standard','2023-03-10','2024-03-10'),
 (5,2,'Standard','2024-04-05','2024-10-05'),
 (6,3,'Free','2023-06-05','2024-06-05'),
 (7,4,'Premium','2023-07-20','2024-07-20'),
 (8,4,'Free','2024-08-15','2024-12-15'),
 (9,5,'Standard','2023-09-01','2024-09-01'),
 (10,5,'Standard','2024-10-01','2025-03-01'),
 (11,6,'Free','2023-12-15','2024-12-15'),
 (12,6,'Free','2025-01-10','2025-05-10'),
 (13,7,'Premium','2023-11-02','2024-11-02'),
 (14,8,'Standard','2023-08-17','2024-08-17'),
 (15,9,'Free','2023-05-06','2024-05-06'),
 (16,10,'Premium','2023-10-22','2024-10-22'),
 (17,11,'Standard','2023-04-12','2024-04-12'),
 (18,11,'Free','2024-05-05','2024-08-05'),
 (19,12,'Free','2023-02-10','2024-02-10'),
 (20,13,'Premium','2023-09-25','2024-09-25'),
 (21,13,'Standard','2024-10-10','2025-10-10'),
 (22,14,'Standard','2023-06-30','2024-06-30'),
 (23,15,'Free','2023-01-28','2024-01-28'),
 (24,16,'Premium','2023-07-10','2024-07-10'),
 (25,16,'Standard','2024-08-15','2025-08-15'),
 (26,17,'Standard','2023-11-15','2024-11-15'),
 (27,18,'Free','2023-12-03','2024-12-03'),
 (28,19,'Premium','2023-03-21','2024-03-21'),
 (29,19,'Free','2024-04-21','2024-07-21'),
 (30,20,'Standard','2023-08-11','2024-08-11'),
 (31,20,'Free','2024-09-11','2024-12-11'),
 (32,2,'Free','2025-01-10','2026-01-10'),
 (33,6,'Free','2024-03-15','2024-06-15'),
 (34,1,'Standard','2025-07-15','2026-01-15'),
 (35,7,'Standard','2024-02-05','2024-08-05'),
 (36,14,'Premium','2024-07-30','2025-07-30'),
 (37,3,'Free','2024-04-01','2024-10-01'),
 (38,10,'Premium','2024-05-01','2025-05-01'),
 (39,5,'Free','2024-10-10','2025-10-10'),
 (40,19,'Standard','2025-05-01','2026-05-01'),
 (41,13,'Standard','2024-01-20','2025-01-20'),
 (42,4,'Standard','2024-03-15','2025-03-15'),
 (43,17,'Premium','2024-12-20','2025-12-20'),
 (44,18,'Free','2024-06-10','2025-06-10'),
 (45,9,'Premium','2023-07-05','2024-07-05'),
 (46,6,'Free','2024-08-20','2025-08-20'),
 (47,15,'Standard','2024-12-15','2025-12-15'),
 (48,8,'Free','2024-05-05','2024-11-05'),
 (49,12,'Standard','2024-11-02','2025-11-02'),
 (50,11,'Free','2024-01-30','2024-04-30'),
 (51,10,'Premium','2024-12-05','2025-12-05'),
 (52,19,'Free','2025-02-10','2025-05-10'),
 (53,20,'Premium','2024-04-10','2025-04-10'),
 (54,3,'Premium','2024-07-01','2025-07-01'),
 (55,9,'Standard','2024-03-01','2025-03-01'),
 (56,2,'Free','2024-11-15','2025-05-15'),
 (57,7,'Premium','2024-09-10','2025-09-10'),
 (58,16,'Free','2024-12-01','2025-06-01'),
 (59,4,'Standard','2025-02-10','2026-02-10'),
 (60,13,'Premium','2024-08-10','2025-08-10'),
 (61,5,'Free','2024-04-15','2024-10-15'),
 (62,8,'Premium','2024-03-05','2025-03-05'),
 (63,16,'Free','2025-05-15','2026-05-15'),
 (64,1,'Standard','2024-10-01','2025-10-01'),
 (65,2,'Premium','2024-06-01','2025-06-01'),
 (66,5,'Standard','2024-07-10','2025-07-10'),
 (67,11,'Premium','2024-09-01','2025-09-01'),
 (68,4,'Free','2024-01-01','2024-07-01'),
 (69,10,'Standard','2025-02-01','2026-02-01'),
 (70,13,'Standard','2024-09-15','2025-09-15'),
 (71,17,'Free','2024-11-15','2025-11-15'),
 (72,18,'Standard','2024-05-15','2025-05-15'),
 (73,19,'Free','2024-06-10','2025-06-10'),
 (74,6,'Premium','2025-09-01','2026-09-01'),
 (75,15,'Free','2025-01-20','2025-07-20'),
 (76,7,'Standard','2024-10-20','2025-10-20'),
 (77,14,'Premium','2025-01-05','2026-01-05'),
 (78,9,'Free','2025-03-15','2025-09-15'),
 (79,11,'Standard','2024-07-01','2025-07-01'),
 (80,2,'Free','2025-12-15','2026-06-15'),
 (81,8,'Standard','2024-06-15','2025-06-15'),
 (82,6,'Premium','2025-04-05','2026-04-05'),
 (83,3,'Standard','2025-01-10','2026-01-10'),
 (84,5,'Free','2025-08-10','2026-08-10'),
 (85,18,'Premium','2024-12-01','2025-12-01'),
 (86,1,'Free','2025-05-10','2025-11-10'),
 (87,12,'Free','2025-01-15','2025-07-15'),
 (88,16,'Free','2025-10-01','2026-10-01'),
 (89,2,'Standard','2025-04-05','2026-04-05'),
 (90,17,'Free','2025-06-20','2025-12-20'),
 (91,4,'Standard','2025-03-15','2026-03-15'),
 (92,13,'Free','2025-02-05','2025-08-05'),
 (93,7,'Premium','2025-08-20','2026-08-20'),
 (94,8,'Free','2025-02-05','2025-08-05'),
 (95,10,'Free','2025-03-10','2025-09-10'),
 (96,20,'Standard','2024-10-10','2025-10-10'),
 (97,9,'Premium','2024-11-20','2025-11-20'),
 (98,6,'Standard','2024-07-25','2025-07-25'),
 (99,12,'Premium','2024-05-10','2025-05-10'),
 (100,15,'Standard','2024-12-01','2025-12-01');
INSERT INTO "Users" ("UserID","UserName","Email","DateOfBirth") VALUES (1,'John Doe','john.doe@example.com','1990-05-14'),
 (2,'Jane Smith','jane.smith@example.com','1985-09-30'),
 (3,'Alan Brown','alan.brown@example.com','2000-03-22'),
 (4,'Susan White','susan.white@example.com','1992-07-19'),
 (5,'Michael Clark','michael.clark@example.com','1988-01-25'),
 (6,'Linda Davis','linda.davis@example.com','1987-11-11'),
 (7,'Robert Lee','robert.lee@example.com','1993-10-10'),
 (8,'Emily Harris','emily.harris@example.com','1995-02-20'),
 (9,'David Walker','david.walker@example.com','1982-07-07'),
 (10,'Sophia Adams','sophia.adams@example.com','2001-06-30'),
 (11,'James Turner','james.turner@example.com','1994-08-15'),
 (12,'Olivia Scott','olivia.scott@example.com','1998-12-05'),
 (13,'Daniel King','daniel.king@example.com','1991-04-09'),
 (14,'Charlotte Martinez','charlotte.martinez@example.com','1997-09-22'),
 (15,'William Moore','william.moore@example.com','1996-05-19'),
 (16,'Alice Taylor','alice.taylor@example.com','1989-03-12'),
 (17,'Joseph Young','joseph.young@example.com','1984-12-17'),
 (18,'Natalie Wright','natalie.wright@example.com','1992-01-04'),
 (19,'Henry Walker','henry.walker@example.com','1993-06-17'),
 (20,'Victoria Harris','victoria.harris@example.com','1999-10-22');
COMMIT;
