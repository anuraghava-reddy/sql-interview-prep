# SQL Cheatsheet (T-SQL)

> Written for **SQL Server (T-SQL)**. Where MySQL (HackerRank) differs, it's marked **MySQL:**.
> 🚩 = Important (also logged in mistakes.md)

## Logical order of execution
FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → DISTINCT → ORDER BY → TOP/OFFSET

## Filtering
-

## Numeric & math functions

### 🚩 Modulo `%` — remainder / even-odd filter
Returns the remainder of `a ÷ b`.

| Need | T-SQL | Example |
|------|-------|---------|
| Even values | `ID % 2 = 0` | `10 % 2` → 0 |
| Odd values | `ID % 2 = 1` | `7 % 2` → 1 |
| Multiples of N | `ID % N = 0` | `9 % 3` → 0 |

```sql
SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0;
```

> **MySQL:** `MOD(ID, 2)` also works. T-SQL has no `MOD()`, only `%`.

## Aggregation
-

## Joins
-

## Subqueries & CTEs
-

## Window functions
-

## Dates, strings & NULLs
-

## Business metric patterns
<!-- retention, cohorts, funnels, MoM growth -->
-

## Gotchas
- 🚩 `MOD()` doesn't exist in T-SQL. Use `%`.
