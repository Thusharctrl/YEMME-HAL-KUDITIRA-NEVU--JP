-- =============================================
-- QUERIES: Insurance Database
-- =============================================

USE Insurance;

-- Q1. Find the total number of people who owned cars
--     that were involved in accidents in 1989.
SELECT COUNT(DISTINCT P.driverid) AS Total_People
FROM PARTICIPATED P, ACCIDENT A
WHERE P.reportno = A.reportno
AND YEAR(A.accdate) = 1989;

-- Q2. Find the number of accidents in which the cars
--     belonging to "John Smith" were involved.
SELECT COUNT(P.reportno) AS No_Of_Accidents
FROM PARTICIPATED P, PERSON PN
WHERE P.driverid = PN.driverid
AND PN.name = 'John Smith';

-- Q3. Update the damage amount for the car with reg number "KA-12"
--     in the accident with report number 1 to $3000.
UPDATE PARTICIPATED
SET dmgamt = 3000
WHERE regno = 'KA-12' AND reportno = 1;
