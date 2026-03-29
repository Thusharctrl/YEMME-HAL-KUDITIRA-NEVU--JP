-- =============================================
-- DATABASE: Banking
-- =============================================

BRANCH (branch-name PK, branch-city, assets)
ACCOUNT (accno PK, branch-name FK, balance)
DEPOSITOR (customer-name FK, accno FK)
CUSTOMER (customer-name PK, customer-street, customer-city)
LOAN (loan-number PK, branch-name FK, amount)
BORROWER (customer-name FK, loan-number FK)

    5️.Banking DB
Table order: BRANCH → ACCOUNT → CUSTOMER → DEPOSITOR → LOAN → BORROWER
Values to remember:

Branch names: 'synd_nitte', 'Corp_nitte', 'PNB_nitte' → city 'karkala'
Branch names: 'Corp_mang', 'PNB_mang' → city 'Mangalore'
Branch names: 'state_udupi', 'synd_udupi' → city 'Udupi'
Make Rakesh have 2+ accounts at karkala branches — needed for Q1
Make one customer have accounts in all cities — needed for Q2
Make one customer have accounts in 2+ karkala branches — needed for Q3

CREATE DATABASE bank;
USE bank;

CREATE TABLE BRANCH (
    bname  VARCHAR(15) PRIMARY KEY,
    bcity  VARCHAR(15),
    assets REAL
);

INSERT INTO BRANCH VALUES ('synd_nitte',  'karkala',   200000);
INSERT INTO BRANCH VALUES ('Corp_nitte',  'karkala',   300000);
INSERT INTO BRANCH VALUES ('PNB_nitte',   'karkala',   100000);
INSERT INTO BRANCH VALUES ('Corp_mang',   'Mangalore', 300000);
INSERT INTO BRANCH VALUES ('PNB_mang',    'Mangalore', 500000);
INSERT INTO BRANCH VALUES ('state_udupi', 'Udupi',     500000);
INSERT INTO BRANCH VALUES ('synd_udupi',  'Udupi',     500000);

CREATE TABLE ACCOUNT (
    accno   INT PRIMARY KEY,
    bname   VARCHAR(15),
    balance REAL,
    FOREIGN KEY (bname) REFERENCES BRANCH(bname) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO ACCOUNT VALUES (12345, 'synd_nitte',  6000);
INSERT INTO ACCOUNT VALUES (12340, 'synd_nitte',  6000);
INSERT INTO ACCOUNT VALUES (21345, 'synd_nitte',  10000);
INSERT INTO ACCOUNT VALUES (14341, 'Corp_nitte',  15000);
INSERT INTO ACCOUNT VALUES (14345, 'Corp_nitte',  15000);
INSERT INTO ACCOUNT VALUES (12455, 'Corp_nitte',  17000);
INSERT INTO ACCOUNT VALUES (13345, 'PNB_nitte',   11000);
INSERT INTO ACCOUNT VALUES (13346, 'PNB_nitte',   11000);
INSERT INTO ACCOUNT VALUES (13347, 'PNB_nitte',   11000);
INSERT INTO ACCOUNT VALUES (13340, 'PNB_nitte',   11000);
INSERT INTO ACCOUNT VALUES (15345, 'synd_udupi',  11000);
INSERT INTO ACCOUNT VALUES (12453, 'PNB_mang',    17000);
INSERT INTO ACCOUNT VALUES (21346, 'PNB_mang',    10000);
INSERT INTO ACCOUNT VALUES (12450, 'PNB_mang',    17000);
INSERT INTO ACCOUNT VALUES (12452, 'PNB_mang',    17000);
INSERT INTO ACCOUNT VALUES (13245, 'state_udupi', 5000);
INSERT INTO ACCOUNT VALUES (13241, 'state_udupi', 5000);
INSERT INTO ACCOUNT VALUES (12375, 'state_udupi', 12000);
INSERT INTO ACCOUNT VALUES (12377, 'state_udupi', 12000);
INSERT INTO ACCOUNT VALUES (12378, 'state_udupi', 12000);
INSERT INTO ACCOUNT VALUES (15342, 'state_udupi', 19000);
INSERT INTO ACCOUNT VALUES (12451, 'state_udupi', 17000);

CREATE TABLE CUSTOMER (
    cname   VARCHAR(20) PRIMARY KEY,
    cstreet VARCHAR(25),
    ccity   VARCHAR(20)
);

INSERT INTO CUSTOMER VALUES ('Rakesh',     '3rd main',   'karkala');
INSERT INTO CUSTOMER VALUES ('Ramesh',     '4th main',   'karkala');
INSERT INTO CUSTOMER VALUES ('Rajesh',     '4th block',  'Mangalore');
INSERT INTO CUSTOMER VALUES ('Kareem',     '456 nagar',  'Mangalore');
INSERT INTO CUSTOMER VALUES ('John Smith', '452 street', 'Udupi');

CREATE TABLE DEPOSITOR (
    cname VARCHAR(20),
    accno INT,
    PRIMARY KEY (cname, accno),
    FOREIGN KEY (cname) REFERENCES CUSTOMER(cname)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (accno) REFERENCES ACCOUNT(accno)   ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO DEPOSITOR VALUES ('Rakesh',     12340);
INSERT INTO DEPOSITOR VALUES ('Rakesh',     13345);
INSERT INTO DEPOSITOR VALUES ('Rakesh',     14345);
INSERT INTO DEPOSITOR VALUES ('Rakesh',     13346);
INSERT INTO DEPOSITOR VALUES ('Rakesh',     15342);
INSERT INTO DEPOSITOR VALUES ('Rakesh',     14341);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12345);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12375);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12377);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12378);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     13340);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12451);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12452);
INSERT INTO DEPOSITOR VALUES ('Ramesh',     12455);
INSERT INTO DEPOSITOR VALUES ('Kareem',     21346);
INSERT INTO DEPOSITOR VALUES ('Kareem',     13245);
INSERT INTO DEPOSITOR VALUES ('Rajesh',     15345);
INSERT INTO DEPOSITOR VALUES ('Rajesh',     13241);
INSERT INTO DEPOSITOR VALUES ('John Smith', 21345);
INSERT INTO DEPOSITOR VALUES ('John Smith', 12453);
INSERT INTO DEPOSITOR VALUES ('John Smith', 13347);

CREATE TABLE LOAN (
    loanno INT PRIMARY KEY,
    bname  VARCHAR(15),
    amount REAL,
    FOREIGN KEY (bname) REFERENCES BRANCH(bname) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO LOAN VALUES (1,  'Corp_mang',   12000);
INSERT INTO LOAN VALUES (2,  'Corp_mang',   11000);
INSERT INTO LOAN VALUES (3,  'Corp_mang',   10000);
INSERT INTO LOAN VALUES (4,  'Corp_nitte',  16000);
INSERT INTO LOAN VALUES (5,  'Corp_nitte',  13000);
INSERT INTO LOAN VALUES (6,  'PNB_mang',    12000);
INSERT INTO LOAN VALUES (7,  'state_udupi', 20000);
INSERT INTO LOAN VALUES (8,  'state_udupi', 23000);
INSERT INTO LOAN VALUES (9,  'synd_nitte',  32000);
INSERT INTO LOAN VALUES (10, 'PNB_nitte',   12000);
INSERT INTO LOAN VALUES (11, 'Corp_mang',   10000);
INSERT INTO LOAN VALUES (12, 'synd_nitte',  10000);
INSERT INTO LOAN VALUES (13, 'state_udupi', 12000);
INSERT INTO LOAN VALUES (14, 'synd_udupi',  12000);

CREATE TABLE BORROWER (
    cname  VARCHAR(20),
    loanno INT,
    PRIMARY KEY (cname, loanno),
    FOREIGN KEY (cname)  REFERENCES CUSTOMER(cname) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (loanno) REFERENCES LOAN(loanno)    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO BORROWER VALUES ('John Smith', 1);
INSERT INTO BORROWER VALUES ('John Smith', 2);
INSERT INTO BORROWER VALUES ('John Smith', 3);
INSERT INTO BORROWER VALUES ('John Smith', 13);
INSERT INTO BORROWER VALUES ('John Smith', 14);
INSERT INTO BORROWER VALUES ('Kareem',     4);
INSERT INTO BORROWER VALUES ('Kareem',     5);
INSERT INTO BORROWER VALUES ('Rajesh',     6);
INSERT INTO BORROWER VALUES ('Rajesh',     11);
INSERT INTO BORROWER VALUES ('Rajesh',     12);
INSERT INTO BORROWER VALUES ('Rajesh',     7);
INSERT INTO BORROWER VALUES ('Rajesh',     8);
INSERT INTO BORROWER VALUES ('Rakesh',     9);
INSERT INTO BORROWER VALUES ('Ramesh',     10);

-- Q1: customers with 2+ accounts at all branches in a city
SELECT D.cname FROM DEPOSITOR D, ACCOUNT A, BRANCH B
WHERE D.accno = A.accno AND A.bname = B.bname AND B.bcity = 'karkala'
GROUP BY D.cname, A.bname HAVING COUNT(D.accno) >= 2;

-- Q2: customers with account in 1+ branch in all cities
SELECT C.cname FROM CUSTOMER C
WHERE NOT EXISTS (
    SELECT DISTINCT B1.bcity FROM BRANCH B1
    WHERE NOT EXISTS (
        SELECT A.bname FROM ACCOUNT A, DEPOSITOR D, BRANCH B
        WHERE D.accno = A.accno AND A.bname = B.bname
        AND B.bcity = B1.bcity AND D.cname = C.cname
    )
);

-- Q3: customers with accounts in 2+ branches in a specific city
SELECT D.cname FROM DEPOSITOR D, ACCOUNT A, BRANCH B
WHERE D.accno = A.accno AND A.bname = B.bname AND B.bcity = 'karkala'
GROUP BY D.cname HAVING COUNT(DISTINCT A.bname) >= 2;
