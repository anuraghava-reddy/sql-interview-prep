# Mistakes Log

# SQL Mistakes & Learnings

A running log of errors I made while solving problems, and what I learned from each.

| # | Date | Source | Problem | Topic | Mistake | Fix / Learning |
|---|------|--------|---------|-------|---------|----------------|
| 1 | 2026-10-16 | HackerRank | [Revising the Select Query I](https://www.hackerrank.com/challenges/revising-the-select-query/problem) | Select & filtering | Wrote `COUNTRYCODE = USA` without quotes, so the query errored | Text values need single quotes (`'USA'`). Numbers don't (`100000`). |
## Recurring patterns
<!-- After a few entries, group the repeats here, e.g. "forgot NULLs in NOT IN", "WHERE vs HAVING" -->
