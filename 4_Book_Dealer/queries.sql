-- =============================================
-- QUERIES: Book Dealer Database
-- =============================================

USE bk_shop;

-- Q1. Find the author of the book which has maximum sales.
SELECT A.authorid, A.aname
FROM AUTHOR A, CATALOGUE C, ORDER_DET O
WHERE A.authorid = C.authorid
AND C.bookid = O.bookid
GROUP BY A.authorid, A.aname, C.bookid
HAVING SUM(O.qty) >= ALL (
    SELECT SUM(O1.qty)
    FROM ORDER_DET O1
    GROUP BY O1.bookid
);

-- Q2. Increase the price of the books published by
--     a specific publisher by 10%.
UPDATE CATALOGUE
SET price = price * 1.1
WHERE pubid = (
    SELECT pubid FROM PUBLISHER WHERE pname = 'Pearson'
);

-- Q3. Find the number of orders for the book that has minimum sales.
SELECT COUNT(O.ordno) AS Num_Orders
FROM ORDER_DET O
WHERE O.bookid = (
    SELECT TOP 1 bookid
    FROM ORDER_DET
    GROUP BY bookid
    ORDER BY SUM(qty) ASC
);
