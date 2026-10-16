# SQL Dialects Comparison

A side-by-side reference of how **SQL Server (T-SQL)**, **MySQL**, **PostgreSQL**, **Oracle** and **SQLite** differ and where they are the same, with example queries written for each.

---

## Table of Contents

1. [The Databases at a Glance](#1-the-databases-at-a-glance)
2. [Similarities: What Works Everywhere](#2-similarities-what-works-everywhere)
3. [Sample Table Used in Examples](#3-sample-table-used-in-examples)
4. [Limiting Rows](#4-limiting-rows)
5. [String Functions](#5-string-functions)
6. [Date and Time Functions](#6-date-and-time-functions)
7. [NULL Handling and Conditionals](#7-null-handling-and-conditionals)
8. [Type Conversion](#8-type-conversion)
9. [Math and Division](#9-math-and-division)
10. [Aggregation Differences](#10-aggregation-differences)
11. [Table Creation (DDL)](#11-table-creation-ddl)
12. [Dialect-Specific Quirks](#12-dialect-specific-quirks)
13. [Common Traps](#13-common-traps)
14. [Portable SQL Checklist](#14-portable-sql-checklist)

---

## 1. The Databases at a Glance

| Database | Dialect | Owner / License | Typical Use |
|---|---|---|---|
| **SQL Server** | T-SQL (Transact-SQL) | Microsoft, commercial (free Express / Developer editions) | Corporate systems, Power BI / Microsoft stack |
| **MySQL** | MySQL SQL | Oracle Corp., open source | Web apps, startups |
| **MariaDB** | MySQL-compatible | Community fork of MySQL, open source | Drop-in MySQL replacement |
| **PostgreSQL** | PL/pgSQL | Community, open source | Modern apps, analytics, closest to the SQL standard |
| **Oracle** | PL/SQL | Oracle Corp., commercial | Banks, large enterprises, ERP |
| **SQLite** | SQLite SQL | Public domain | Embedded in apps and phones, single file, no server |
| **BigQuery / Snowflake / Redshift** | Mostly PostgreSQL-like | Cloud vendors | Data warehouses for analytics teams |

---

## 2. Similarities: What Works Everywhere

These are part of the ANSI SQL standard and behave the same (or nearly the same) in all five databases.

| Category | Portable Syntax |
|---|---|
| Querying | `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `DISTINCT` |
| Joins | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`*, `FULL OUTER JOIN`*, `CROSS JOIN` |
| Set operations | `UNION`, `UNION ALL`, `INTERSECT`*, `EXCEPT`* |
| Subqueries | `IN`, `EXISTS`, scalar subqueries, derived tables |
| CTEs | `WITH cte AS (...)` and recursive CTEs* |
| Aggregates | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` |
| Window functions | `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`, `LAG`, `LEAD`, `FIRST_VALUE`, `SUM() OVER (...)` |
| Conditionals | `CASE WHEN ... THEN ... ELSE ... END` |
| NULL handling | `COALESCE`, `NULLIF`, `IS NULL`, `IS NOT NULL` |
| Conversion | `CAST(x AS type)` |
| Strings | `UPPER`, `LOWER`, `TRIM`, `LTRIM`, `RTRIM`, `REPLACE` |
| Math | `ROUND`, `ABS`, `FLOOR` |
| Data changes | `INSERT`, `UPDATE`, `DELETE` |

\* Small exceptions: MySQL has no `FULL OUTER JOIN` (use `LEFT JOIN ... UNION ... RIGHT JOIN`). MySQL added `INTERSECT` / `EXCEPT` only in 8.0.31. Oracle uses `MINUS` instead of `EXCEPT` (21c+ accepts both). SQL Server writes `WITH` for recursive CTEs, while MySQL, PostgreSQL and SQLite write `WITH RECURSIVE`. SQLite added `RIGHT` / `FULL JOIN` in 3.39.

**Example: this query runs unchanged on all five**

```sql
WITH dept_avg AS (
    SELECT dept,
           AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept
)
SELECT e.first_name,
       e.dept,
       e.salary,
       CASE WHEN e.salary > d.avg_salary THEN 'Above'
            ELSE 'Below or Equal'
       END AS vs_dept_avg,
       RANK() OVER (PARTITION BY e.dept ORDER BY e.salary DESC) AS dept_rank
FROM employees e
JOIN dept_avg d
  ON e.dept = d.dept
ORDER BY e.dept, dept_rank;
```

---

## 3. Sample Table Used in Examples

```sql
employees
+--------+------------+-----------+-------------+--------+------------+
| emp_id | first_name | last_name | dept        | salary | hire_date  |
+--------+------------+-----------+-------------+--------+------------+
| 1      | Asha       | Rao       | Sales       | 55000  | 2021-03-15 |
| 2      | Ravi       | Kumar     | Engineering | 82000  | 2019-07-01 |
| 3      | Meena      | NULL      | Sales       | 61000  | 2022-11-20 |
| 4      | Kiran      | Reddy     | HR          | NULL   | 2020-01-10 |
+--------+------------+-----------+-------------+--------+------------+
```

---

## 4. Limiting Rows

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| First N rows | `SELECT TOP 5` | `LIMIT 5` | `LIMIT 5` | `FETCH FIRST 5 ROWS ONLY` | `LIMIT 5` |
| Skip + take | `OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY` | `LIMIT 5 OFFSET 10` | `LIMIT 5 OFFSET 10` | `OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY` | `LIMIT 5 OFFSET 10` |
| Ties included | `TOP 5 WITH TIES` | not supported | `FETCH FIRST 5 ROWS WITH TIES` (13+) | `FETCH FIRST 5 ROWS WITH TIES` | not supported |

**Example: top 3 highest-paid employees**

```sql
-- SQL Server
SELECT TOP 3 first_name, salary
FROM employees
ORDER BY salary DESC;

-- MySQL / PostgreSQL / SQLite
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Oracle (12c+)  — also valid in SQL Server 2012+ only with OFFSET 0 ROWS first
SELECT first_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 3 ROWS ONLY;
```

> Note: `ORDER BY ... OFFSET ... FETCH` is the ANSI-standard way and works in SQL Server, PostgreSQL and Oracle.

---

## 5. String Functions

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Concatenate | `a + b` or `CONCAT(a, b)` | `CONCAT(a, b)` | `a \|\| b` or `CONCAT(a, b)` | `a \|\| b` or `CONCAT(a, b)` (2 args only) | `a \|\| b` |
| Concat with separator | `CONCAT_WS(' ', a, b)` | `CONCAT_WS(' ', a, b)` | `CONCAT_WS(' ', a, b)` | not built in | `CONCAT_WS` (3.44+) |
| Length (characters) | `LEN(s)` | `CHAR_LENGTH(s)` | `LENGTH(s)` | `LENGTH(s)` | `LENGTH(s)` |
| Length (bytes) | `DATALENGTH(s)` | `LENGTH(s)` | `OCTET_LENGTH(s)` | `LENGTHB(s)` | — |
| Substring | `SUBSTRING(s, 1, 3)` | `SUBSTRING(s, 1, 3)` / `SUBSTR` | `SUBSTRING(s, 1, 3)` / `SUBSTR` | `SUBSTR(s, 1, 3)` | `SUBSTR(s, 1, 3)` |
| Left / Right N chars | `LEFT(s, 3)` / `RIGHT(s, 3)` | `LEFT` / `RIGHT` | `LEFT` / `RIGHT` | `SUBSTR(s, 1, 3)` / `SUBSTR(s, -3)` | `SUBSTR(s, 1, 3)` / `SUBSTR(s, -3)` |
| Find position | `CHARINDEX('a', s)` | `LOCATE('a', s)` / `INSTR(s, 'a')` | `POSITION('a' IN s)` / `STRPOS(s, 'a')` | `INSTR(s, 'a')` | `INSTR(s, 'a')` |
| Reverse | `REVERSE(s)` | `REVERSE(s)` | `REVERSE(s)` | `REVERSE(s)` (undocumented) | not built in |
| Repeat | `REPLICATE(s, 3)` | `REPEAT(s, 3)` | `REPEAT(s, 3)` | `RPAD(s, LENGTH(s)*3, s)` | not built in |
| Pad left | `RIGHT('000' + s, 5)` | `LPAD(s, 5, '0')` | `LPAD(s, 5, '0')` | `LPAD(s, 5, '0')` | not built in |
| Regex match | not built in (`LIKE` only) | `REGEXP` / `REGEXP_LIKE` | `~` / `SIMILAR TO` | `REGEXP_LIKE` | `REGEXP` (extension) |

**Example: full name + first 3 letters of department**

```sql
-- SQL Server
SELECT first_name + ' ' + last_name AS full_name,      -- NULL if last_name is NULL
       CONCAT(first_name, ' ', last_name) AS full_name_safe,  -- NULL treated as ''
       LEFT(dept, 3) AS dept_code,
       LEN(first_name) AS name_length
FROM employees;

-- MySQL
SELECT CONCAT(first_name, ' ', last_name) AS full_name,      -- NULL if any part is NULL!
       CONCAT_WS(' ', first_name, last_name) AS full_name_safe,
       LEFT(dept, 3) AS dept_code,
       CHAR_LENGTH(first_name) AS name_length
FROM employees;

-- PostgreSQL
SELECT first_name || ' ' || last_name AS full_name,           -- NULL if last_name is NULL
       CONCAT(first_name, ' ', last_name) AS full_name_safe,
       LEFT(dept, 3) AS dept_code,
       LENGTH(first_name) AS name_length
FROM employees;

-- Oracle
SELECT first_name || ' ' || last_name AS full_name,           -- NULL treated as '' in Oracle
       SUBSTR(dept, 1, 3) AS dept_code,
       LENGTH(first_name) AS name_length
FROM employees;

-- SQLite
SELECT first_name || ' ' || last_name AS full_name,
       SUBSTR(dept, 1, 3) AS dept_code,
       LENGTH(first_name) AS name_length
FROM employees;
```

> **NULL behaviour in concatenation differs.** For Meena (last_name NULL):
> - SQL Server `+` → NULL; `CONCAT()` → `'Meena '`
> - MySQL `CONCAT()` → NULL; `CONCAT_WS()` → `'Meena'`
> - PostgreSQL `||` → NULL; `CONCAT()` → `'Meena '`
> - Oracle `||` → `'Meena '` (Oracle treats NULL as an empty string)

**Example: group values into one string**

```sql
-- SQL Server (2017+) / PostgreSQL
SELECT dept, STRING_AGG(first_name, ', ') AS names
FROM employees GROUP BY dept;

-- MySQL / SQLite
SELECT dept, GROUP_CONCAT(first_name SEPARATOR ', ') AS names   -- SQLite: GROUP_CONCAT(first_name, ', ')
FROM employees GROUP BY dept;

-- Oracle
SELECT dept, LISTAGG(first_name, ', ') WITHIN GROUP (ORDER BY first_name) AS names
FROM employees GROUP BY dept;
```

---

## 6. Date and Time Functions

This is where dialects differ the most.

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Current date + time | `GETDATE()` / `SYSDATETIME()` | `NOW()` | `NOW()` | `SYSDATE` / `SYSTIMESTAMP` | `DATETIME('now')` |
| Current date only | `CAST(GETDATE() AS DATE)` | `CURDATE()` | `CURRENT_DATE` | `TRUNC(SYSDATE)` | `DATE('now')` |
| Year | `YEAR(d)` / `DATEPART(year, d)` | `YEAR(d)` | `EXTRACT(YEAR FROM d)` | `EXTRACT(YEAR FROM d)` | `STRFTIME('%Y', d)` |
| Month | `MONTH(d)` | `MONTH(d)` | `EXTRACT(MONTH FROM d)` | `EXTRACT(MONTH FROM d)` | `STRFTIME('%m', d)` |
| Month name | `DATENAME(month, d)` | `MONTHNAME(d)` | `TO_CHAR(d, 'Month')` | `TO_CHAR(d, 'Month')` | not built in |
| Add days | `DATEADD(day, 5, d)` | `DATE_ADD(d, INTERVAL 5 DAY)` | `d + INTERVAL '5 days'` | `d + 5` | `DATE(d, '+5 days')` |
| Add months | `DATEADD(month, 2, d)` | `DATE_ADD(d, INTERVAL 2 MONTH)` | `d + INTERVAL '2 months'` | `ADD_MONTHS(d, 2)` | `DATE(d, '+2 months')` |
| Days between | `DATEDIFF(day, start, end)` | `DATEDIFF(end, start)` | `end - start` | `end - start` | `JULIANDAY(end) - JULIANDAY(start)` |
| Months between | `DATEDIFF(month, start, end)` | `TIMESTAMPDIFF(MONTH, start, end)` | `EXTRACT(YEAR FROM AGE(end, start))*12 + EXTRACT(MONTH FROM AGE(end, start))` | `MONTHS_BETWEEN(end, start)` | — |
| Format date | `FORMAT(d, 'yyyy-MM-dd')` | `DATE_FORMAT(d, '%Y-%m-%d')` | `TO_CHAR(d, 'YYYY-MM-DD')` | `TO_CHAR(d, 'YYYY-MM-DD')` | `STRFTIME('%Y-%m-%d', d)` |
| Truncate to month | `DATETRUNC(month, d)` (2022+) | `DATE_FORMAT(d, '%Y-%m-01')` | `DATE_TRUNC('month', d)` | `TRUNC(d, 'MM')` | `DATE(d, 'start of month')` |
| Last day of month | `EOMONTH(d)` | `LAST_DAY(d)` | `DATE_TRUNC('month', d) + INTERVAL '1 month - 1 day'` | `LAST_DAY(d)` | `DATE(d, 'start of month', '+1 month', '-1 day')` |
| String → date | `CONVERT(DATE, '2024-01-31')` | `STR_TO_DATE('31-01-2024', '%d-%m-%Y')` | `TO_DATE('31-01-2024', 'DD-MM-YYYY')` | `TO_DATE('31-01-2024', 'DD-MM-YYYY')` | stored as text |

**Example: tenure in days and hires per year**

```sql
-- SQL Server
SELECT first_name,
       DATEDIFF(day, hire_date, GETDATE()) AS days_employed,
       YEAR(hire_date) AS hire_year,
       FORMAT(hire_date, 'MMM yyyy') AS hire_month
FROM employees;

-- MySQL                         ⚠ argument order is reversed
SELECT first_name,
       DATEDIFF(CURDATE(), hire_date) AS days_employed,
       YEAR(hire_date) AS hire_year,
       DATE_FORMAT(hire_date, '%b %Y') AS hire_month
FROM employees;

-- PostgreSQL
SELECT first_name,
       CURRENT_DATE - hire_date AS days_employed,
       EXTRACT(YEAR FROM hire_date) AS hire_year,
       TO_CHAR(hire_date, 'Mon YYYY') AS hire_month
FROM employees;

-- Oracle
SELECT first_name,
       TRUNC(SYSDATE) - hire_date AS days_employed,
       EXTRACT(YEAR FROM hire_date) AS hire_year,
       TO_CHAR(hire_date, 'Mon YYYY') AS hire_month
FROM employees;

-- SQLite
SELECT first_name,
       CAST(JULIANDAY('now') - JULIANDAY(hire_date) AS INTEGER) AS days_employed,
       STRFTIME('%Y', hire_date) AS hire_year
FROM employees;
```

**Example: monthly hire count**

```sql
-- SQL Server (2022+)
SELECT DATETRUNC(month, hire_date) AS hire_month, COUNT(*) AS hires
FROM employees GROUP BY DATETRUNC(month, hire_date);

-- MySQL
SELECT DATE_FORMAT(hire_date, '%Y-%m-01') AS hire_month, COUNT(*) AS hires
FROM employees GROUP BY DATE_FORMAT(hire_date, '%Y-%m-01');

-- PostgreSQL
SELECT DATE_TRUNC('month', hire_date) AS hire_month, COUNT(*) AS hires
FROM employees GROUP BY DATE_TRUNC('month', hire_date);

-- Oracle
SELECT TRUNC(hire_date, 'MM') AS hire_month, COUNT(*) AS hires
FROM employees GROUP BY TRUNC(hire_date, 'MM');
```

---

## 7. NULL Handling and Conditionals

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Replace NULL (2 args) | `ISNULL(x, 0)` | `IFNULL(x, 0)` | `COALESCE(x, 0)` | `NVL(x, 0)` | `IFNULL(x, 0)` |
| Replace NULL (portable) | `COALESCE(x, y, 0)` | `COALESCE` | `COALESCE` | `COALESCE` | `COALESCE` |
| NULL if equal | `NULLIF(a, b)` | `NULLIF` | `NULLIF` | `NULLIF` | `NULLIF` |
| Inline if | `IIF(cond, a, b)` | `IF(cond, a, b)` | `CASE` only | `CASE` / `DECODE(x, v1, r1, default)` | `IIF(cond, a, b)` |
| If not null / else | — | — | — | `NVL2(x, if_not_null, if_null)` | — |
| Boolean type | `BIT` (0/1) | `BOOLEAN` = `TINYINT(1)` | `BOOLEAN` (true/false) | `BOOLEAN` only in 23ai+ | integers 0/1 |

**Example: missing salary shown as 0, and a high/low label**

```sql
-- SQL Server
SELECT first_name,
       ISNULL(salary, 0) AS salary,
       IIF(salary >= 60000, 'High', 'Low') AS band
FROM employees;

-- MySQL
SELECT first_name,
       IFNULL(salary, 0) AS salary,
       IF(salary >= 60000, 'High', 'Low') AS band
FROM employees;

-- PostgreSQL / any database (portable version)
SELECT first_name,
       COALESCE(salary, 0) AS salary,
       CASE WHEN salary >= 60000 THEN 'High' ELSE 'Low' END AS band
FROM employees;

-- Oracle
SELECT first_name,
       NVL(salary, 0) AS salary,
       DECODE(dept, 'Sales', 'S', 'HR', 'H', 'Other') AS dept_code
FROM employees;
```

> Note: for Kiran (salary NULL), `IIF` / `IF` / `CASE` all return `'Low'`, because `NULL >= 60000` is not true.

---

## 8. Type Conversion

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Standard cast | `CAST(x AS INT)` | `CAST(x AS SIGNED)` | `CAST(x AS INT)` | `CAST(x AS NUMBER)` | `CAST(x AS INTEGER)` |
| Shorthand | `CONVERT(INT, x)` | `CONVERT(x, SIGNED)` | `x::INT` | `TO_NUMBER(x)` | — |
| Safe cast (NULL on failure) | `TRY_CAST(x AS INT)` | — | — | `CAST(x AS NUMBER DEFAULT NULL ON CONVERSION ERROR)` | — |
| Number → text | `CAST(x AS VARCHAR(10))` | `CAST(x AS CHAR)` | `x::TEXT` | `TO_CHAR(x)` | `CAST(x AS TEXT)` |
| Decimal | `CAST(x AS DECIMAL(10,2))` | `CAST(x AS DECIMAL(10,2))` | `x::NUMERIC(10,2)` | `CAST(x AS NUMBER(10,2))` | `CAST(x AS REAL)` |

> MySQL cannot `CAST(x AS INT)`. Use `SIGNED` or `UNSIGNED`.

---

## 9. Math and Division

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| `5 / 2` | **2** (integer division) | **2.5000** | **2** (integer division) | **2.5** | **2** (integer division) |
| Integer division | `5 / 2` | `5 DIV 2` | `5 / 2` | `TRUNC(5 / 2)` | `5 / 2` |
| Remainder | `5 % 2` | `5 % 2` / `MOD(5, 2)` | `5 % 2` / `MOD(5, 2)` | `MOD(5, 2)` only | `5 % 2` |
| Ceiling | `CEILING(x)` | `CEIL` / `CEILING` | `CEIL` / `CEILING` | `CEIL(x)` | `CEIL(x)` (3.35+) |
| Truncate decimals | `ROUND(x, 2, 1)` | `TRUNCATE(x, 2)` | `TRUNC(x, 2)` | `TRUNC(x, 2)` | — |
| Power | `POWER(x, 2)` | `POWER` / `POW` | `POWER(x, 2)` | `POWER(x, 2)` | `POWER` (3.35+) |
| Random number | `RAND()` | `RAND()` | `RANDOM()` | `DBMS_RANDOM.VALUE` | `RANDOM()` |
| Random row order | `ORDER BY NEWID()` | `ORDER BY RAND()` | `ORDER BY RANDOM()` | `ORDER BY DBMS_RANDOM.VALUE` | `ORDER BY RANDOM()` |

**Example: percentage of employees in Sales**

```sql
-- ❌ Wrong in SQL Server / PostgreSQL / SQLite → returns 0 (integer ÷ integer)
SELECT SUM(CASE WHEN dept = 'Sales' THEN 1 ELSE 0 END) / COUNT(*) * 100
FROM employees;

-- ✅ Works everywhere: multiply by 1.0 / 100.0 first
SELECT ROUND(SUM(CASE WHEN dept = 'Sales' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_sales
FROM employees;
```

Same problem with `AVG()` on an integer column in SQL Server and PostgreSQL:

```sql
-- SQL Server: AVG of INT column returns INT
SELECT AVG(salary) FROM employees;                         -- decimals dropped
SELECT AVG(CAST(salary AS DECIMAL(10,2))) FROM employees;  -- correct
SELECT AVG(salary * 1.0) FROM employees;                   -- correct
```

---

## 10. Aggregation Differences

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Median | `PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY x) OVER ()` (window only) | not built in | `PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY x)` | `MEDIAN(x)` or `PERCENTILE_CONT` | not built in |
| Standard deviation | `STDEV(x)` | `STDDEV(x)` | `STDDEV(x)` | `STDDEV(x)` | not built in |
| Conditional count | `COUNT(CASE WHEN ... THEN 1 END)` | also `SUM(cond)` | also `COUNT(*) FILTER (WHERE cond)` | `COUNT(CASE ...)` | also `COUNT(*) FILTER (WHERE cond)` |
| Selecting non-grouped column | error | allowed if `ONLY_FULL_GROUP_BY` is off | error | error | allowed (picks any row) |

**Example: median salary**

```sql
-- SQL Server
SELECT DISTINCT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) OVER () AS median_salary
FROM employees;

-- PostgreSQL
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary
FROM employees;

-- Oracle
SELECT MEDIAN(salary) AS median_salary FROM employees;

-- MySQL (no median function: use ROW_NUMBER)
WITH ranked AS (
    SELECT salary,
           ROW_NUMBER() OVER (ORDER BY salary) AS rn,
           COUNT(*) OVER () AS cnt
    FROM employees
    WHERE salary IS NOT NULL
)
SELECT ROUND(AVG(salary), 2) AS median_salary
FROM ranked
WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2));
```

---

## 11. Table Creation (DDL)

| Task | SQL Server | MySQL | PostgreSQL | Oracle | SQLite |
|---|---|---|---|---|---|
| Auto-number | `INT IDENTITY(1,1)` | `INT AUTO_INCREMENT` | `INT GENERATED ALWAYS AS IDENTITY` / `SERIAL` | `NUMBER GENERATED ALWAYS AS IDENTITY` | `INTEGER PRIMARY KEY AUTOINCREMENT` |
| Text | `VARCHAR(n)` / `NVARCHAR(n)` | `VARCHAR(n)` | `VARCHAR(n)` / `TEXT` | `VARCHAR2(n)` | `TEXT` |
| Whole number | `INT` / `BIGINT` | `INT` / `BIGINT` | `INT` / `BIGINT` | `NUMBER(10)` | `INTEGER` |
| Decimal | `DECIMAL(10,2)` | `DECIMAL(10,2)` | `NUMERIC(10,2)` | `NUMBER(10,2)` | `REAL` / `NUMERIC` |
| Date + time | `DATETIME2` | `DATETIME` | `TIMESTAMP` | `DATE` (includes time) / `TIMESTAMP` | `TEXT` (ISO string) |
| Drop if exists | `DROP TABLE IF EXISTS t` (2016+) | `DROP TABLE IF EXISTS t` | `DROP TABLE IF EXISTS t` | `DROP TABLE t` (23ai+: `IF EXISTS`) | `DROP TABLE IF EXISTS t` |
| Copy table from query | `SELECT * INTO new_t FROM t` | `CREATE TABLE new_t AS SELECT * FROM t` | `CREATE TABLE new_t AS SELECT * FROM t` | `CREATE TABLE new_t AS SELECT * FROM t` | `CREATE TABLE new_t AS SELECT * FROM t` |

**Example: create the employees table**

```sql
-- SQL Server
CREATE TABLE employees (
    emp_id     INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name  NVARCHAR(50),
    dept       NVARCHAR(50),
    salary     DECIMAL(10,2),
    hire_date  DATE
);

-- MySQL
CREATE TABLE employees (
    emp_id     INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50),
    dept       VARCHAR(50),
    salary     DECIMAL(10,2),
    hire_date  DATE
);

-- PostgreSQL
CREATE TABLE employees (
    emp_id     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50),
    dept       VARCHAR(50),
    salary     NUMERIC(10,2),
    hire_date  DATE
);

-- Oracle
CREATE TABLE employees (
    emp_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name  VARCHAR2(50),
    dept       VARCHAR2(50),
    salary     NUMBER(10,2),
    hire_date  DATE
);

-- SQLite
CREATE TABLE employees (
    emp_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name  TEXT,
    dept       TEXT,
    salary     REAL,
    hire_date  TEXT
);
```

---

## 12. Dialect-Specific Quirks

### SQL Server (T-SQL)
- Identifiers quoted with `[square brackets]`.
- Variables: `DECLARE @x INT = 5;`
- `SELECT ... INTO new_table` creates a table from a query.
- `GO` separates batches in SSMS (it is a client command, not SQL).
- `LEN()` ignores trailing spaces; `DATALENGTH()` does not.
- Default collation is case-insensitive: `'abc' = 'ABC'` is true.

### MySQL
- Identifiers quoted with `` `backticks` ``.
- `||` means logical OR by default, **not** concatenation.
- String comparison is case-insensitive by default.
- `LIMIT` cannot be used inside an `IN (subquery)`.
- Older versions (before 8.0) have no window functions or CTEs.

### PostgreSQL
- Identifiers quoted with `"double quotes"`; unquoted names are folded to lowercase.
- `::` shorthand for casting (`'42'::INT`).
- `ILIKE` for case-insensitive LIKE.
- `DISTINCT ON (col)` keeps the first row per group.
- String comparison is case-sensitive.

### Oracle
- `SELECT` with no table needs `FROM DUAL`: `SELECT SYSDATE FROM DUAL;`
- Empty string `''` is treated as NULL.
- Uses `MINUS` for set difference.
- `ROWNUM` (older) for limiting rows before `FETCH FIRST` existed.
- Table aliases cannot use `AS`: `FROM employees e` (not `employees AS e`).

### SQLite
- Dynamic typing: any column can hold any type.
- No real DATE type; dates are stored as text, real or integer.
- Limited `ALTER TABLE` (cannot drop constraints easily).
- Single file database, no users or permissions.

---

## 13. Common Traps

| Trap | Where | Fix |
|---|---|---|
| Integer division drops decimals | SQL Server, PostgreSQL, SQLite | Multiply by `1.0` or `CAST` to decimal |
| `AVG()` on INT returns INT | SQL Server | `AVG(col * 1.0)` |
| `DATEDIFF` argument order reversed | MySQL vs SQL Server | MySQL: `DATEDIFF(end, start)`; SQL Server: `DATEDIFF(unit, start, end)` |
| `CONCAT` returns NULL if any arg is NULL | MySQL | Use `CONCAT_WS` or `COALESCE` each part |
| `+` concat returns NULL if any arg is NULL | SQL Server | Use `CONCAT()` |
| `''` is NULL | Oracle | Test with `IS NULL`, not `= ''` |
| `||` is OR, not concat | MySQL | Use `CONCAT()` |
| Case-sensitive string matching | PostgreSQL | `ILIKE` or `LOWER()` on both sides |
| `CAST(x AS INT)` fails | MySQL | `CAST(x AS SIGNED)` |
| No `FULL OUTER JOIN` | MySQL | `LEFT JOIN ... UNION ... RIGHT JOIN` |
| No table in SELECT fails | Oracle | Add `FROM DUAL` |
| Same query, different HackerRank result | HackerRank | Check which dialect is selected in the dropdown |

---

## 14. Portable SQL Checklist

Prefer these to write queries that move between databases with the fewest edits:

| Instead of… | Use… |
|---|---|
| `ISNULL` / `IFNULL` / `NVL` | `COALESCE` |
| `IIF` / `IF` / `DECODE` | `CASE WHEN ... END` |
| `CONVERT` / `::` / `TO_NUMBER` | `CAST(x AS type)` |
| `TOP` / `LIMIT` / `ROWNUM` | `ORDER BY ... OFFSET n ROWS FETCH NEXT m ROWS ONLY` (SQL Server, PostgreSQL, Oracle) |
| `LEFT()` / `SUBSTR()` | `SUBSTRING(s, start, length)` (not Oracle) |
| `[col]` / `` `col` `` | `"col"` (ANSI; SQL Server and MySQL need settings) or avoid special characters in names |
| `x / y` with integers | `x * 1.0 / y` |
| `GROUP BY` with non-aggregated columns | List every non-aggregated column in `GROUP BY` |

**Fully portable functions:** `COALESCE`, `NULLIF`, `CASE`, `CAST`, `UPPER`, `LOWER`, `TRIM`, `REPLACE`, `ROUND`, `ABS`, `FLOOR`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, `NTILE`.
