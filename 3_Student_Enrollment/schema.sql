-- =============================================
-- DATABASE: Student Enrollment
-- =============================================

STUDENT (regno PK, name, major, bdate)
COURSE (course# PK, cname, dept)
ENROLL (regno FK, course# FK, sem, marks)
BOOK_ADOPTION (course# FK, sem, book-ISBN FK)
TEXT (book-ISBN PK, book-title, publisher, author)

    3️.Student Enrollment DB
Table order: STUDENT → COURSE → TEXTBOOK → BOOK_ADAPTION → ENROLL
Values to remember:

Dept values: exactly 'CS', 'ENC', 'MECH'
CS courses: 1-DBMS, 2-COMPILER, 3-JAVA
Make CS courses have 3+ books in BOOK_ADAPTION — needed for Q1
Publisher: use 'McGraw' for most books — needed for Q2
Enroll multiple students in CS courses — needed for Q3
CREATE DATABASE st_enroll;
USE st_enroll;

CREATE TABLE STUDENT (
    regno  VARCHAR(10) PRIMARY KEY,
    name   CHAR(15),
    major  CHAR(20),
    bdate  DATETIME
);

INSERT INTO STUDENT VALUES ('111', 'Ravi',    'CS',   '1989-11-09');
INSERT INTO STUDENT VALUES ('112', 'Sudha',   'CS',   '1979-07-04');
INSERT INTO STUDENT VALUES ('113', 'Kumar',   'CS',   '1979-01-06');
INSERT INTO STUDENT VALUES ('114', 'Raju',    'ENC',  '1999-10-02');
INSERT INTO STUDENT VALUES ('115', 'Hemanth', 'MECH', '1988-11-04');

CREATE TABLE COURSE (
    course INT PRIMARY KEY,
    cname  VARCHAR(15),
    dept   CHAR(20)
);

INSERT INTO COURSE VALUES (1, 'DBMS',            'CS');
INSERT INTO COURSE VALUES (2, 'COMPILER',         'CS');
INSERT INTO COURSE VALUES (3, 'JAVA',             'CS');
INSERT INTO COURSE VALUES (4, 'SIG PROCESSING',   'ENC');
INSERT INTO COURSE VALUES (5, 'DIGITAL CIRCUITS', 'ENC');
INSERT INTO COURSE VALUES (6, 'MACHINE DESIGN',   'MECH');
INSERT INTO COURSE VALUES (7, 'THERMODYNAMICS',   'MECH');
INSERT INTO COURSE VALUES (8, 'AUTOCAD',          'MECH');

CREATE TABLE TEXTBOOK (
    bookISBN  INT PRIMARY KEY,
    title     VARCHAR(50),
    publisher VARCHAR(20),
    author    CHAR(20)
);

INSERT INTO TEXTBOOK VALUES (201, 'Fundamentals of DBMS',      'McGraw',  'NAVATHE');
INSERT INTO TEXTBOOK VALUES (202, 'Database Design',           'McGraw',  'Raghu Rama');
INSERT INTO TEXTBOOK VALUES (203, 'Compiler Design',           'Pearson', 'Ulman');
INSERT INTO TEXTBOOK VALUES (204, 'JAVA Complete Reference',   'McGraw',  'BALAGURU');
INSERT INTO TEXTBOOK VALUES (205, 'Signals and Fundamentals',  'McGraw',  'NITHIN');
INSERT INTO TEXTBOOK VALUES (206, 'Machine Theory',            'McGraw',  'Ragavan');
INSERT INTO TEXTBOOK VALUES (207, 'Thermodynamics',            'McGraw',  'Alfred');
INSERT INTO TEXTBOOK VALUES (208, 'Circuit Design',            'McGraw',  'Rajkamal');
INSERT INTO TEXTBOOK VALUES (209, 'Electronic Circuits',       'McGraw',  'Alfred');
INSERT INTO TEXTBOOK VALUES (210, 'Circuits Theory',           'McGraw',  'Alfred');

CREATE TABLE BOOK_ADAPTION (
    course   INT,
    sem      INT,
    bookISBN INT,
    PRIMARY KEY (course, sem, bookISBN),
    FOREIGN KEY (course)   REFERENCES COURSE(course)     ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (bookISBN) REFERENCES TEXTBOOK(bookISBN) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO BOOK_ADAPTION VALUES (1, 5, 201);
INSERT INTO BOOK_ADAPTION VALUES (1, 7, 202);
INSERT INTO BOOK_ADAPTION VALUES (2, 5, 203);
INSERT INTO BOOK_ADAPTION VALUES (2, 6, 203);
INSERT INTO BOOK_ADAPTION VALUES (3, 7, 204);
INSERT INTO BOOK_ADAPTION VALUES (4, 3, 205);
INSERT INTO BOOK_ADAPTION VALUES (4, 5, 209);
INSERT INTO BOOK_ADAPTION VALUES (5, 5, 205);
INSERT INTO BOOK_ADAPTION VALUES (5, 6, 208);
INSERT INTO BOOK_ADAPTION VALUES (5, 2, 210);
INSERT INTO BOOK_ADAPTION VALUES (6, 7, 206);
INSERT INTO BOOK_ADAPTION VALUES (7, 3, 207);
INSERT INTO BOOK_ADAPTION VALUES (7, 3, 206);
INSERT INTO BOOK_ADAPTION VALUES (8, 3, 207);

CREATE TABLE ENROLL (
    regno  VARCHAR(10),
    course INT,
    sem    INT,
    marks  INT,
    PRIMARY KEY (regno, course, sem),
    FOREIGN KEY (regno)  REFERENCES STUDENT(regno)  ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (course) REFERENCES COURSE(course)  ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO ENROLL VALUES ('111', 1, 5, 59);
INSERT INTO ENROLL VALUES ('111', 2, 5, 70);
INSERT INTO ENROLL VALUES ('111', 3, 5, 75);
INSERT INTO ENROLL VALUES ('112', 1, 5, 49);
INSERT INTO ENROLL VALUES ('113', 2, 5, 80);
INSERT INTO ENROLL VALUES ('114', 3, 7, 79);
INSERT INTO ENROLL VALUES ('115', 4, 3, 79);

-- Q1: textbooks for CS dept courses with >2 books
SELECT C.course, T.bookISBN, T.title
FROM COURSE C, BOOK_ADAPTION B, TEXTBOOK T
WHERE C.course = B.course AND B.bookISBN = T.bookISBN AND C.dept = 'CS'
AND C.course IN (
    SELECT course FROM BOOK_ADAPTION
    GROUP BY course HAVING COUNT(DISTINCT bookISBN) > 2
) ORDER BY T.title;

-- Q2: dept where all books are from one publisher
SELECT DISTINCT C.dept FROM COURSE C
WHERE NOT EXISTS (
    SELECT B.bookISBN FROM BOOK_ADAPTION B
    WHERE B.course IN (SELECT course FROM COURSE WHERE dept = C.dept)
    AND B.bookISBN NOT IN (SELECT bookISBN FROM TEXTBOOK WHERE publisher = 'McGraw')
);

-- Q3: bookISBNs of dept with max students
SELECT T.bookISBN, T.title
FROM TEXTBOOK T, BOOK_ADAPTION B, COURSE C
WHERE T.bookISBN = B.bookISBN AND B.course = C.course
AND C.dept IN (
    SELECT C1.dept FROM COURSE C1, ENROLL E
    WHERE C1.course = E.course
    GROUP BY C1.dept
    HAVING COUNT(DISTINCT E.regno) >= ALL (
        SELECT COUNT(DISTINCT E1.regno) FROM COURSE C2, ENROLL E1
        WHERE C2.course = E1.course GROUP BY C2.dept
    )
);
