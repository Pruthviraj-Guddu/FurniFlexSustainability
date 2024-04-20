
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

