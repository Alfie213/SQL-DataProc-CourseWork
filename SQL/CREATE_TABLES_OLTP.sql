CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    Email VARCHAR(100),
    DateOfBirth DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductType VARCHAR(50),
    DeveloperID INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (DeveloperID) REFERENCES Developers(DeveloperID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    ProductID INT,
    OrderDate TEXT,
    Quantity INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Devices (
    DeviceID INT PRIMARY KEY,
    DeviceName VARCHAR(100),
    Manufacturer VARCHAR(100)
);

CREATE TABLE DeviceFeatures (
    FeatureID INT PRIMARY KEY,
    FeatureDescription VARCHAR(255),
    DeviceID INT,
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY,
    UserID INT,
    SubscriptionType VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Developers (
    DeveloperID INT PRIMARY KEY,
    DeveloperName VARCHAR(100),
    Country VARCHAR(50),
    FoundedYear INT
);

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
