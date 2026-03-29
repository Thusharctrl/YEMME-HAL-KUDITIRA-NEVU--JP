-- =============================================
-- DATABASE: Book Dealer
-- =============================================

AUTHOR (author-id PK, name, city, country)
PUBLISHER (publisher-id PK, name, city, country)
CATALOG (book-id PK, title, author-id FK, publisher-id FK, category-id FK, year, price)
CATEGORY (category-id PK, description)
ORDER-DETAILS (order-no, book-id FK, quantity)

    4️. Book Dealer DB
Table order: AUTHOR → PUBLISHER → CATEGORY → CATALOGUE → ORDER_DET
Values to remember:

Author IDs: 110-115, Publisher IDs: 201-205
Book IDs: 301-307, Category IDs: 1-5
Publishers: McGRAW, Pearson, GKP, MediTech, Sun
Make one book have the highest total qty in ORDER_DET — needed for Q1
Make one book have the lowest total qty — needed for Q3
Q2 updates Pearson publisher books by 10%
CREATE DATABASE bk_shop;
USE bk_shop;

CREATE TABLE AUTHOR (
    authorid INT PRIMARY KEY,
    aname    VARCHAR(20),
    city     VARCHAR(20),
    country  VARCHAR(20)
);

INSERT INTO AUTHOR VALUES (110, 'Elmasri',   'Houston',    'Canada');
INSERT INTO AUTHOR VALUES (111, 'Sebesta',   'Mangalore',  'India');
INSERT INTO AUTHOR VALUES (112, 'Elmasri',   'Houston',    'Canada');
INSERT INTO AUTHOR VALUES (113, 'Bharath K', 'Bangalore',  'India');
INSERT INTO AUTHOR VALUES (114, 'Willy Z',   'California', 'USA');
INSERT INTO AUTHOR VALUES (115, 'Salma',     'Dakha',      'Bangladesh');

CREATE TABLE PUBLISHER (
    pubid   INT PRIMARY KEY,
    pname   VARCHAR(20),
    city    VARCHAR(20),
    country VARCHAR(20)
);

INSERT INTO PUBLISHER VALUES (201, 'McGRAW',   'Mangalore',  'India');
INSERT INTO PUBLISHER VALUES (202, 'Pearson',  'Bangalore',  'India');
INSERT INTO PUBLISHER VALUES (203, 'GKP',      'Bangalore',  'India');
INSERT INTO PUBLISHER VALUES (204, 'MediTech', 'Delhi',      'India');
INSERT INTO PUBLISHER VALUES (205, 'Sun',      'Ahmedabad',  'India');

CREATE TABLE CATEGORY (
    catid    INT PRIMARY KEY,
    descript VARCHAR(30)
);

INSERT INTO CATEGORY VALUES (1, 'All Children Books');
INSERT INTO CATEGORY VALUES (2, 'Cooking Books');
INSERT INTO CATEGORY VALUES (3, 'Popular Novels');
INSERT INTO CATEGORY VALUES (4, 'Small Story Books');
INSERT INTO CATEGORY VALUES (5, 'Medical Books');

CREATE TABLE CATALOGUE (
    bookid   INT PRIMARY KEY,
    title    VARCHAR(20),
    pubid    INT,
    authorid INT,
    catid    INT,
    yr       INT,
    price    INT,
    FOREIGN KEY (pubid)    REFERENCES PUBLISHER(pubid)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (authorid) REFERENCES AUTHOR(authorid)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (catid)    REFERENCES CATEGORY(catid)   ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO CATALOGUE VALUES (301, 'Panchatantra',      201, 111, 1, 2000, 300);
INSERT INTO CATALOGUE VALUES (302, 'Vegetables',        202, 111, 2, 2000, 400);
INSERT INTO CATALOGUE VALUES (303, 'Yogasana',          203, 112, 5, 2002, 600);
INSERT INTO CATALOGUE VALUES (304, 'Stories of Village',204, 113, 4, 2005, 100);
INSERT INTO CATALOGUE VALUES (305, 'Triangle',          205, 114, 3, 2008, 1000);
INSERT INTO CATALOGUE VALUES (306, 'Naughtiest Girl',   201, 110, 3, 2007, 1500);
INSERT INTO CATALOGUE VALUES (307, 'Cookery',           205, 115, 2, 2006, 100);

CREATE TABLE ORDER_DET (
    ordno  INT,
    bookid INT,
    qty    INT,
    PRIMARY KEY (ordno, bookid),
    FOREIGN KEY (bookid) REFERENCES CATALOGUE(bookid) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO ORDER_DET VALUES (1, 301, 10);
INSERT INTO ORDER_DET VALUES (1, 302,  6);
INSERT INTO ORDER_DET VALUES (1, 307, 23);
INSERT INTO ORDER_DET VALUES (2, 301, 15);
INSERT INTO ORDER_DET VALUES (2, 304, 11);
INSERT INTO ORDER_DET VALUES (3, 304, 15);
INSERT INTO ORDER_DET VALUES (4, 301,  3);
INSERT INTO ORDER_DET VALUES (4, 305,  8);
INSERT INTO ORDER_DET VALUES (5, 303, 20);
INSERT INTO ORDER_DET VALUES (5, 306,  6);
INSERT INTO ORDER_DET VALUES (5, 305,  7);

-- Q1: author of book with max sales
SELECT A.authorid, A.aname
FROM AUTHOR A, CATALOGUE C, ORDER_DET O
WHERE A.authorid = C.authorid AND C.bookid = O.bookid
GROUP BY A.authorid, A.aname, C.bookid
HAVING SUM(O.qty) >= ALL (SELECT SUM(O1.qty) FROM ORDER_DET O1 GROUP BY O1.bookid);

-- Q2: increase price by 10% for specific publisher
UPDATE CATALOGUE SET price = price * 1.1
WHERE pubid = (SELECT pubid FROM PUBLISHER WHERE pname = 'Pearson');

-- Q3: number of orders for book with min sales
SELECT COUNT(O.ordno) AS Num_Orders FROM ORDER_DET O
WHERE O.bookid = (
    SELECT TOP 1 bookid FROM ORDER_DET
    GROUP BY bookid ORDER BY SUM(qty) ASC
);
