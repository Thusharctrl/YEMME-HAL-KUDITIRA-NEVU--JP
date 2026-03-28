-- =============================================
-- QUERIES: Student Enrollment Database
-- =============================================

USE st_enroll;

-- Q1. Produce a list of textbooks (Course#, Book-ISBN, Book-title)
--     in alphabetical order for courses offered by 'CS' department
--     that use more than two books.
SELECT C.course, T.bookISBN, T.title
FROM COURSE C, BOOK_ADAPTION B, TEXTBOOK T
WHERE C.course = B.course
AND B.bookISBN = T.bookISBN
AND C.dept = 'CS'
AND C.course IN (
    SELECT course
    FROM BOOK_ADAPTION
    GROUP BY course
    HAVING COUNT(DISTINCT bookISBN) > 2
)
ORDER BY T.title;

-- Q2. List any department that has all its adopted books
--     published by a specific publisher.
SELECT DISTINCT C.dept
FROM COURSE C
WHERE NOT EXISTS (
    SELECT B.bookISBN
    FROM BOOK_ADAPTION B
    WHERE B.course IN (
        SELECT course FROM COURSE WHERE dept = C.dept
    )
    AND B.bookISBN NOT IN (
        SELECT bookISBN FROM TEXTBOOK WHERE publisher = 'McGraw'
    )
);

-- Q3. List the bookISBNs and book titles of the department
--     that has the maximum number of students.
SELECT T.bookISBN, T.title
FROM TEXTBOOK T, BOOK_ADAPTION B, COURSE C
WHERE T.bookISBN = B.bookISBN
AND B.course = C.course
AND C.dept = (
    SELECT TOP 1 C1.dept
    FROM COURSE C1, ENROLL E
    WHERE C1.course = E.course
    GROUP BY C1.dept
    ORDER BY COUNT(DISTINCT E.regno) DESC
);
