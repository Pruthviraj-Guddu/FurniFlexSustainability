--Queries for Recommendation System

--List all available listings with their owners
SELECT l.itemID, l.price, l.description, l.sellByDate, l.status, a.username
FROM Listings l
         INNER JOIN Accounts a ON l.ownerID = a.accountID
WHERE l.status = 'available';

--Retrieve all transactions along with buyer and seller details (Receipt)
SELECT t.transactionID, t.itemID, t.buyerID, t.sellerID, a_buyer.username AS buyer_username, a_seller.username AS seller_username
FROM Transactions t
         JOIN Accounts a_buyer ON t.buyerID = a_buyer.accountID
         JOIN Accounts a_seller ON t.sellerID = a_seller.accountID;

-- Count the number of listings created by each user
SELECT a.username, COUNT(l.itemID) AS listing_count
FROM Accounts a
         LEFT JOIN Listings l ON a.accountID = l.ownerID
GROUP BY a.username;

--Retrieve all message information received by a particular accountID(inbox)
SELECT m.messageID, m.senderID, m.receiverID, m.encryptedContent
FROM Messages m
WHERE m.receiverID = :accountID;

-- retrieve all messages sent by a particular accountID (Sent box)
SELECT m.messageID, m.senderID, m.receiverID, m.encryptedContent
FROM Messages m
WHERE m.senderID = :accountID;

--Retrieves the receiver ID, sender ID, and encrypted content of the most recent message sent to each receiver
-- based on the maximum message ID (most recent chat)

SELECT m.receiverID, m.senderID, m.encryptedContent
FROM Messages m
         INNER JOIN (
    SELECT receiverID, MAX(messageID) AS max_messageID
    FROM Messages
    GROUP BY receiverID
) latest ON m.receiverID = latest.receiverID AND m.messageID = latest.max_messageID;


