# 🗄️ DBMS Lab — CS2601-1

SQL queries and schema scripts for the **Database Management Systems Lab** at NMAMIT (NITTE Deemed University), B.Tech CSE.

---

## 📚 Databases Covered

| # | Database | Topics |
|---|----------|--------|
| 1 | Insurance | Joins, Aggregation, Update |
| 2 | Order Processing | Group By, Subqueries, Division |
| 3 | Student Enrollment | Nested queries, NOT EXISTS |
| 4 | Book Dealer | Aggregation, Update, Max/Min |
| 5 | Banking | Division queries, Multi-city conditions |

---

## 📁 Repo Structure

```
DBMS-Lab/
│
├── 1_Insurance/
│   ├── schema.sql        # Table creation + sample data
│   └── queries.sql       # All queries for Insurance DB
│
├── 2_Order/
│   ├── schema.sql
│   └── queries.sql
│
├── 3_Student_Enrollment/
│   ├── schema.sql
│   └── queries.sql
│
├── 4_Book_Dealer/
│   ├── schema.sql
│   └── queries.sql
│
└── 5_Banking/
    ├── schema.sql
    └── queries.sql
```

---

## ⚙️ How to Run

1. Open **SQL Server Management Studio (SSMS)**
2. Run `schema.sql` first to create tables and insert sample data
3. Run `queries.sql` to execute the lab queries

> All scripts are written for **Microsoft SQL Server**. Functions like `YEAR()`, `TOP`, and `DATETIME` are MS SQL specific.

---

## 📝 Lab Questions Covered

### i. Insurance Database
- Find total people who owned cars involved in accidents in a given year
- Find number of accidents involving cars belonging to a specific person
- Update damage amount for a specific car and accident report

### ii. Order Processing Database
- List customer name, number of orders, and average order amount
- List items with more than 2 orders shipped from at least 2 warehouses
- List customers who have ordered every item the company produces

### iii. Student Enrollment Database
- List textbooks alphabetically for CS dept courses using more than 2 books
- List departments where all adopted books are from a specific publisher
- List book ISBNs and titles for the department with maximum students

### iv. Book Dealer Database
- Find the author of the book with maximum sales
- Increase price of books by a specific publisher by 10%
- Find number of orders for the book with minimum sales

### v. Banking Database
- Find customers with at least 2 accounts at all branches in a specific city
- Find customers with accounts in at least 1 branch across all cities
- Find customers with accounts in at least 2 branches in a specific city

---

## 🧾 Course Info

- **Course Code:** CS2601-1  
- **Course Type:** PCC Lab  
- **Credits:** 01  
- **Department:** Computer Science & Engineering  
- **University:** NITTE (Deemed to be University)

---

## 📖 Reference Books

1. *Database Systems Models, Languages, Design and Application Programming* — Elmasri & Navathe, 7th Ed, Pearson
2. *Database Management Systems* — Ramakrishnan & Gehrke, McGraw Hill

---

> Made with 💀 and caffeine during lab season.
