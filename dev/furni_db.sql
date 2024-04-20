-- Create tables
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

-- Trigger to automatically match new accounts to old accounts by graduation year
CREATE OR REPLACE TRIGGER match_graduation_year
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
    INSERT INTO Transactions (transactionID, buyerID, sellerID, itemID)
    SELECT NULL, :new.accountID, a.accountID, NULL
    FROM Accounts a
    WHERE a.graduationYear = :new.startYear;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- No matching account found, do nothing
END;


-- Function for recommendation system based on user schoolName
CREATE OR REPLACE FUNCTION get_recommendations(p_schoolName IN VARCHAR2)
RETURN SYS_REFCURSOR
AS
    recommendations SYS_REFCURSOR;
BEGIN
    OPEN recommendations FOR
    SELECT l.*
    FROM Listings l
    JOIN Accounts a ON l.ownerID = a.accountID
    WHERE a.schoolName = p_schoolName
    AND l.status = 'available';
    RETURN recommendations;
END;
