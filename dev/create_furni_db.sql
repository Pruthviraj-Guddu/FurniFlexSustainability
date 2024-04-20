
--drop table in case your db already
DROP TABLE IF EXISTS Student;
-- Create table
CREATE TABLE Student (
    studentEmail VARCHAR(100) PRIMARY KEY,
    name VARCHAR(100),
    phoneNumber VARCHAR(20),
    startYear INT,
    schoolName VARCHAR(100),
    address VARCHAR(255)
);

--drop table in case your db already
DROP TABLE IF EXISTS Accounts;
-- Create table
CREATE TABLE Accounts (
    accountID INT PRIMARY KEY,
    studentEmail VARCHAR(100) UNIQUE,
    username VARCHAR(50),
    password VARCHAR(50),
    graduationYear INT,
    startYear INT,
    expirationDate DATE,
    paymentCardInformation VARCHAR(100),
    schoolName VARCHAR(100)
);

--drop table in case your db already
DROP TABLE IF EXISTS Listings;
-- Create table
CREATE TABLE Listings (
    itemID INT PRIMARY KEY,
    ownerID INT REFERENCES Accounts(accountID),
    price INT,
    description VARCHAR(255),
    sellByDate DATE,
    status VARCHAR(20)
);

--drop table in case your db already
DROP TABLE IF EXISTS Transactions;
-- Create table
CREATE TABLE Transactions (
    transactionID INT PRIMARY KEY,
    buyerID INT REFERENCES Accounts(accountID),
    sellerID INT REFERENCES Accounts(accountID),
    itemID INT REFERENCES Listings(itemID)
);

--drop table in case your db already
DROP TABLE IF EXISTS Messages;
-- Create table
CREATE TABLE Messages (
    messageID INT PRIMARY KEY,
    senderID INT REFERENCES Accounts(accountID),
    receiverID INT REFERENCES Accounts(accountID),
    encryptedContent VARCHAR(4000)
);


INSERT INTO Student (studentEmail, name, phoneNumber, startYear, schoolName, address) VALUES ('raj@drexel.edu', "raj", "987654321", 2024, "Drexel University", "Spring Garden");
INSERT INTO Student (studentEmail, name, phoneNumber, startYear, schoolName, address) 
VALUES 
    ('emma@harvard.edu', 'Emma', '123456789', 2023, 'Harvard University', 'Cambridge'),
    ('liam@stanford.edu', 'Liam', '456789123', 2022, 'Stanford University', 'Palo Alto');


INSERT INTO Accounts (accountID, studentEmail, username, password, graduationYear, startYear, expirationDate, paymentCardInformation) 
VALUES 
    (1, 'raj@drexel.edu', 'raj2024', 'password123', 2028, 2024, '2028-05-01', '1234 5678 9012 3456'),
    (2, 'emma@harvard.edu', 'emma2023', 'qwerty456', 2027, 2023, '2027-06-01', '9876 5432 1098 7654'),
    (3, 'liam@stanford.edu', 'liam22', 'abc123xyz', 2026, 2022, '2026-07-01', '5678 9012 3456 7890');


INSERT INTO Listings (itemID, ownerID, price, description, sellByDate, status) 
VALUES 
    (101, 1, 50, 'Used Calculus textbook', '2024-05-01', 'Active'),
    (102, 2, 100, 'Graphing calculator', '2024-06-01', 'Active'),
    (103, 3, 20, 'Chemistry lab goggles', '2024-07-01', 'Active');


INSERT INTO Transactions (transactionID, buyerID, sellerID, itemID) 
VALUES 
    (201, 2, 1, 101),
    (202, 3, 2, 102),
    (203, 1, 3, 103);


INSERT INTO Messages (messageID, senderID, receiverID, encryptedContent) 
VALUES 
    (301, 1, 2, 'Message content 1'),
    (302, 2, 3, 'Encrypted message content 2'),
    (303, 3, 1, 'Encrypted message content 3');
