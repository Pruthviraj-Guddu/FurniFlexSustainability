

--drop table in case your db already
DROP TABLE IF EXISTS Student CASCADE CONSTRAINTS;
-- Create table
CREATE TABLE Student (
                         studentEmail VARCHAR(100) PRIMARY KEY,
                         name VARCHAR(100) NOT NULL,
                         phoneNumber VARCHAR(20) NOT NULL,
                         startYear INT NOT NULL,
                         schoolName VARCHAR(100) NOT NULL,
                         address VARCHAR(255) NOT NULL
);

--drop table in case your db already
DROP TABLE IF EXISTS Accounts CASCADE CONSTRAINTS;
-- Create table
CREATE TABLE Accounts (
                          accountID INT PRIMARY KEY,
                          studentEmail VARCHAR(100) UNIQUE,
                          username VARCHAR(50) NOT NULL ,
                          password VARCHAR(50) NOT NULL,
                          graduationYear INT NOT NULL,
                          startYear INT NOT NULL,
                          expirationDate DATE NOT NULL ,
                          paymentCardInformation VARCHAR(100),
                          FOREIGN KEY (studentEmail) REFERENCES Student(studentEmail)
);

--drop table in case your db already
DROP TABLE IF EXISTS Listings CASCADE CONSTRAINTS;
-- Create table
CREATE TABLE Listings (
                          itemID INT PRIMARY KEY,
                          ownerID INT NOT NULL ,
                          price INT NOT NULL,
                          description VARCHAR(255),
                          sellByDate DATE,
                          status VARCHAR(20) NOT NULL,
                          FOREIGN KEY (ownerID) REFERENCES Accounts(accountID)
);

--drop table in case your db already
DROP TABLE IF EXISTS Transactions CASCADE CONSTRAINTS;
-- Create table
CREATE TABLE Transactions (
                              transactionID INT PRIMARY KEY,
                              buyerID INT NOT NULL,
                              sellerID INT NOT NULL,
                              itemID INT NOT NULL ,
                              FOREIGN KEY (buyerID) REFERENCES Accounts(accountID),
                              FOREIGN KEY (sellerID) REFERENCES Accounts(accountID),
                              FOREIGN KEY (itemID) REFERENCES Listings(itemID)
);

--drop table in case your db already
DROP TABLE IF EXISTS Messages CASCADE CONSTRAINTS;
-- Create table
CREATE TABLE Messages (
                          messageID INT PRIMARY KEY,
                          senderID INT NOT NULL,
                          receiverID INT NOT NULL ,
                          encryptedContent VARCHAR(4000),
                          FOREIGN KEY (senderID) REFERENCES Accounts(accountID) ,
                          FOREIGN KEY (receiverID) REFERENCES Accounts(accountID)
);

