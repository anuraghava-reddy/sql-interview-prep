# Mistakes Log

# SQL Mistakes & Learnings

A running log of errors I made while solving problems, and what I learned from each.

| # | Date | Source | Problem | Topic | Mistake | Fix / Learning |
|---|------|--------|---------|-------|---------|----------------|
| 1 | 2026-10-16 | HackerRank | [Revising the Select Query I](https://www.hackerrank.com/challenges/revising-the-select-query/problem) | Select & filtering | Wrote `COUNTRYCODE = USA` without quotes, so the query errored | Text values need single quotes (`'USA'`). Numbers don't (`100000`). |
| 2 | 2026-10-16 | HackerRank | 🚩 [Weather Observation Station 3](https://www.hackerrank.com/challenges/weather-observation-station-3/problem) | Select & filtering, `MOD()` | Didn't know how to filter even IDs, so I had to look up the solution | `MOD(ID, 2) = 0` keeps even IDs because `MOD` returns the remainder (even → 0, odd → 1). Add `DISTINCT` to remove duplicate cities. In SQL Server, use `ID % 2 = 0`. **IMPORTANT, re-solve on Day 7/11/14.** |
## Recurring patterns
<!-- After a few entries, group the repeats here, e.g. "forgot NULLs in NOT IN", "WHERE vs HAVING" -->
