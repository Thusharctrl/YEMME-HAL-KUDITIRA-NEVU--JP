-- =============================================
-- QUERIES: Banking Database
-- =============================================

USE bank;

-- Q1. Find all customers who have at least 2 accounts
--     at all branches located in a specific city.
SELECT D.cname
FROM DEPOSITOR D, ACCOUNT A, BRANCH B
WHERE D.accno = A.accno
AND A.bname = B.bname
AND B.bcity = 'karkala'
GROUP BY D.cname, A.bname
HAVING COUNT(D.accno) >= 2;

-- Q2. Find all customers who have accounts in
--     at least 1 branch located in all the cities.
SELECT C.cname
FROM CUSTOMER C
WHERE NOT EXISTS (
    SELECT DISTINCT B1.bcity FROM BRANCH B1
    WHERE NOT EXISTS (
        SELECT A.bname
        FROM ACCOUNT A, DEPOSITOR D, BRANCH B
        WHERE D.accno = A.accno
        AND A.bname = B.bname
        AND B.bcity = B1.bcity
        AND D.cname = C.cname
    )
);

-- Q3. Find all customers who have accounts in
--     at least 2 branches located in a specific city.
SELECT D.cname
FROM DEPOSITOR D, ACCOUNT A, BRANCH B
WHERE D.accno = A.accno
AND A.bname = B.bname
AND B.bcity = 'karkala'
GROUP BY D.cname
HAVING COUNT(DISTINCT A.bname) >= 2;
