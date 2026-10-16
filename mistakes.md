# Mistakes Log

# SQL Mistakes & Learnings

A running log of errors I made while solving problems, and what I learned from each.

| # | Date | Source | Problem | Topic | Mistake | Fix / Learning |
|---|------|--------|---------|-------|---------|----------------|
| 1 | 2026-10-16 | HackerRank | [Revising the Select Query I](https://www.hackerrank.com/challenges/revising-the-select-query/problem) | Select & filtering | Wrote `COUNTRYCODE = USA` without quotes, so the query errored | Text values need single quotes (`'USA'`). Numbers don't (`100000`). |
| 2 | 2026-10-16 | HackerRank | 🚩 [Weather Observation Station 3](https://www.hackerrank.com/challenges/weather-observation-station-3/problem) | Select & filtering, `MOD()` | Knew the even-number logic but couldn't recall the SQL function for the remainder | `MOD(ID, 2) = 0` keeps even IDs because `MOD` returns the remainder (even → 0, odd → 1). Add `DISTINCT` to remove duplicate cities. In SQL Server, use `ID % 2 = 0`. |
| 3 | 2026-10-16 | HackerRank | 🚩 [Weather Observation Station 5](https://www.hackerrank.com/challenges/weather-observation-station-5/problem) | Strings, ordering & aggregation | Mixed SQL Server syntax (`LEN()`, `TOP 1`) into MySQL, put `MIN()`/`MAX()` in `WHERE`, returned only CITY, and missed the alphabetical tie-break | MySQL: `LENGTH()` + `LIMIT 1` at the end. SQL Server: `LEN()` + `TOP 1` after `SELECT`. Aggregates can't go in `WHERE`. Use `ORDER BY LENGTH(CITY), CITY` to break ties A–Z. |
## Recurring patterns
<!-- After a few entries, group the repeats here, e.g. "forgot NULLs in NOT IN", "WHERE vs HAVING" -->
