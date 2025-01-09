CREATE TABLE FactOrders (
    FactOrderID INTEGER PRIMARY KEY,
    UserID INTEGER,
    ProductID INTEGER,
    TotalQuantity INTEGER,
    TotalAmount DECIMAL(10, 2),
    OrderMonth INTEGER,
    OrderYear INTEGER,
    FOREIGN KEY (UserID) REFERENCES DimUsers(UserID),
    FOREIGN KEY (ProductID) REFERENCES DimProducts(ProductID)
);

CREATE TABLE FactSubscriptions (
    FactSubscriptionID INTEGER PRIMARY KEY,
    UserID INTEGER,
    SubscriptionType VARCHAR(50),
    TotalSubscriptions INTEGER,
    StartYear INTEGER,
    EndYear INTEGER,
    FOREIGN KEY (UserID) REFERENCES DimUsers(UserID)
);

CREATE TABLE DeveloperHistory (
    DeveloperID INTEGER,
    DeveloperName VARCHAR(100),
    Country VARCHAR(50),
    FoundedYear INTEGER,
    StartDate DATE,
    EndDate DATE,
    IsCurrent BOOLEAN,
    PRIMARY KEY (DeveloperID, StartDate)
);
