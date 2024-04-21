--  match new accounts to old accounts by graduation year
SELECT *
FROM Accounts
WHERE graduationYear = (
    SELECT startYear
    FROM Student
    WHERE studentEmail = 'student_email'
);


-- Function for recommendation system based on user schoolName
SELECT DISTINCT a.accountID
FROM Accounts a
WHERE EXISTS (
    SELECT 1
    FROM Student s
    WHERE s.schoolName = (
        SELECT schoolName
        FROM Student
        WHERE studentEmail = a.studentEmail
    )
      AND a.accountID <> (
        SELECT accountID
        FROM Student
        WHERE studentEmail = a.studentEmail
    )
);


-- Automatically delete listing when status changes to sold or remove
DELETE FROM Listings
WHERE status IN ('sold', 'remove');