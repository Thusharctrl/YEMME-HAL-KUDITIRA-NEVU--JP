-- =============================================
-- QUERIES: Order Processing Database
-- =============================================

USE ord_proc;

-- Q1. Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT
--     where middle column = total orders by customer,
--     last column = average order amount for that customer.
SELECT C.cname,
       COUNT(O.orderid) AS No_Of_Orders,
       AVG(O.ordamt)    AS AVG_ORDER_AMT
FROM CUSTOMER C, C_ORDER O
WHERE C.custid = O.custid
GROUP BY C.cname;

-- Q2. For each item that has more than two orders, list the item,
--     number of orders shipped from at least two warehouses,
--     and total quantity of items shipped.
SELECT OI.itemid,
       COUNT(DISTINCT OI.orderid) AS Num_Orders,
       SUM(OI.qty)                AS Total_Qty
FROM ORDER_ITEM OI
WHERE OI.orderid IN (
    SELECT S.orderid
    FROM SHIPMENT S
    GROUP BY S.orderid
    HAVING COUNT(DISTINCT S.warehouseid) >= 2
)
GROUP BY OI.itemid
HAVING COUNT(DISTINCT OI.orderid) > 2;

-- Q3. List the customers who have ordered every item
--     that the company produces.
SELECT C.cname
FROM CUSTOMER C
WHERE NOT EXISTS (
    SELECT itemid FROM ITEM
    WHERE itemid NOT IN (
        SELECT OI.itemid
        FROM C_ORDER O, ORDER_ITEM OI
        WHERE O.orderid = OI.orderid
        AND O.custid = C.custid
    )
);
