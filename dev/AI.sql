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


-- Trigger to automatically delete listing when status changes to sold or remove
CREATE OR REPLACE TRIGGER delete_listing_trigger
BEFORE UPDATE ON Listings
FOR EACH ROW
BEGIN
    IF :new.status = 'sold' OR :new.status = 'remove' THEN
        DELETE FROM Listings WHERE itemID = :old.itemID;
    END IF;
END;