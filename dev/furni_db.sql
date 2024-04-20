
--drop table in case your db already
DROP TABLE IF EXISTS Student;
-- Create table
CREATE TABLE Student (
    studentEmail VARCHAR2(100) PRIMARY KEY,
    name VARCHAR2(100),
    phoneNumber VARCHAR2(20),
    startYear NUMBER,
    schoolName VARCHAR2(100),
    address VARCHAR2(255)
);

--drop table in case your db already
DROP TABLE IF EXISTS Accounts;
-- Create table
CREATE TABLE Accounts (
    accountID NUMBER PRIMARY KEY,
    studentEmail VARCHAR2(100) UNIQUE,
    username VARCHAR2(50),
    password VARCHAR2(50),
    graduationYear NUMBER,
    startYear NUMBER,
    expirationDate DATE,
    paymentCardInformation VARCHAR2(100),
    schoolName VARCHAR2(100)
);

--drop table in case your db already
DROP TABLE IF EXISTS Listings;
-- Create table
CREATE TABLE Listings (
    itemID NUMBER PRIMARY KEY,
    ownerID NUMBER REFERENCES Accounts(accountID),
    price NUMBER,
    description VARCHAR2(255),
    sellByDate DATE,
    status VARCHAR2(20)
);

--drop table in case your db already
DROP TABLE IF EXISTS Transactions;
-- Create table
CREATE TABLE Transactions (
    transactionID NUMBER PRIMARY KEY,
    buyerID NUMBER REFERENCES Accounts(accountID),
    sellerID NUMBER REFERENCES Accounts(accountID),
    itemID NUMBER REFERENCES Listings(itemID)
);

--drop table in case your db already
DROP TABLE IF EXISTS Messages;
-- Create table
CREATE TABLE Messages (
    messageID NUMBER PRIMARY KEY,
    senderID NUMBER REFERENCES Accounts(accountID),
    receiverID NUMBER REFERENCES Accounts(accountID),
    encryptedContent VARCHAR2(4000)
);

