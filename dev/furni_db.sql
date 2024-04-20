-- Create tables

CREATE TABLE Student (
    studentEmail VARCHAR2(100) PRIMARY KEY,
    name VARCHAR2(100),
    phoneNumber VARCHAR2(20),
    startYear NUMBER,
    schoolName VARCHAR2(100),
    address VARCHAR2(255)
);

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

CREATE TABLE Listings (
    itemID NUMBER PRIMARY KEY,
    ownerID NUMBER REFERENCES Accounts(accountID),
    price NUMBER,
    description VARCHAR2(255),
    sellByDate DATE,
    status VARCHAR2(20)
);

CREATE TABLE Transactions (
    transactionID NUMBER PRIMARY KEY,
    buyerID NUMBER REFERENCES Accounts(accountID),
    sellerID NUMBER REFERENCES Accounts(accountID),
    itemID NUMBER REFERENCES Listings(itemID)
);

CREATE TABLE Messages (
    messageID NUMBER PRIMARY KEY,
    senderID NUMBER REFERENCES Accounts(accountID),
    receiverID NUMBER REFERENCES Accounts(accountID),
    encryptedContent VARCHAR2(4000)
);

