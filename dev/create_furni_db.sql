
--drop table in case your db already
DROP TABLE IF EXISTS Student;
--drop table in case your db already
DROP TABLE IF EXISTS Accounts ;
--drop table in case your db already
DROP TABLE IF EXISTS Listings;
--drop table in case your db already
DROP TABLE IF EXISTS Transactions ;
--drop table in case your db already
DROP TABLE IF EXISTS Messages ;

-- Create table
CREATE TABLE Student (
                     studentEmail VARCHAR(100) PRIMARY KEY,
                     name VARCHAR(100) NOT NULL,
                     phoneNumber VARCHAR(20) NOT NULL,
                     startYear INT NOT NULL,
                     schoolName VARCHAR(100) NOT NULL,
                     address VARCHAR(255) NOT NULL
);


-- Create table
CREATE TABLE Accounts (
                          accountID INT PRIMARY KEY,
                          studentEmail VARCHAR(100) UNIQUE,
                          username VARCHAR(50) NOT NULL ,
                          password VARCHAR(50) NOT NULL,
                          graduationYear INT NOT NULL,
                          expirationDate DATE NOT NULL ,
                          paymentCardInformation VARCHAR(100),
                          FOREIGN KEY (studentEmail) REFERENCES Student(studentEmail)
);


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


-- Create table
CREATE TABLE Messages (
                          messageID INT PRIMARY KEY,
                          senderID INT NOT NULL,
                          receiverID INT NOT NULL ,
                          encryptedContent VARCHAR(4000),
                          FOREIGN KEY (senderID) REFERENCES Accounts(accountID) ,
                          FOREIGN KEY (receiverID) REFERENCES Accounts(accountID)
);


INSERT INTO Student (studentEmail, name, phoneNumber, startYear, schoolName, address) VALUES ('raj@drexel.edu', 'raj', '+1-(987)-654-7321', 2024, 'Drexel University', 'Spring Garden');
INSERT INTO Student (studentEmail, name, phoneNumber, startYear, schoolName, address) 
VALUES 
    ('ama@harvard.edu', 'Sewa', '+1-(888)-654-7321', 2023, 'Harvard University', 'Cambridge'),
    ('jilu@stanford.edu', 'Jilu', '+1-(304)-654-7321', 2022, 'Stanford University', 'Palo Alto'),
    ('gina@upenn.edu', 'gina', '+1-(301)-654-7321', 2022, 'Stanford University', 'Palo Alto'),
    ('sam@gsu.edu', 'sam', '+1-(555)-654-7321', 2023, 'Drexel University', 'Spring Garden'),
    ('jakes@cornell.edu', 'jakes', '+1-(457)-654-7321', 2021, 'Harvard University', 'Cambridge');


INSERT INTO Accounts (accountID, studentEmail, username, password, graduationYear, expirationDate, paymentCardInformation)
VALUES 
    (1, 'raj@drexel.edu', 'raj2024', 'password123', 2028,  '2028-05-01', '1234 5678 9012 3456'),
    (2, 'ama@harvard.edu', 'sewa2023', 'qwerty456', 2027, '2027-06-01', '9876 5432 1098 7654'),
    (3, 'jilu@stanford.edu', 'jilu2022', 'abc123xyz', 2026, '2026-07-01', '5678 9012 3456 7890'),
    (4, 'gina@upenn.edu', 'gina300', 'password123', 2022, '2024-12-31', '1234-5678-9012-3456'),
    (5, 'sam@gsu.edu', 'sam700', 'password456', 2023, '2024-12-31', '9876-5432-1098-7654'),
    (6, 'jakes@cornell.edu', 'jakes400', 'password789', 2022, '2024-12-31', '2468-1357-8024-6803');


INSERT INTO Listings (itemID, ownerID, price, description, sellByDate, status) 
VALUES 
    (101, 1, 50, 'Used Calculus textbook', '2024-05-01', 'Active'),
    (102, 2, 100, 'Graphing calculator', '2024-06-01', 'sold'),
    (103, 3, 20, 'Chemistry lab goggles', '2024-07-01', 'remove');


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





