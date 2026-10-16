-- Problem: Revising the Select Query II
-- Platform: HackerRank | Track: SQL > Basic Select
-- Link: https://www.hackerrank.com/challenges/revising-the-select-query-2/problem
-- Task: Query the NAME field for all American cities in the CITY table
--       with populations larger than 120000. CountryCode for America is USA.

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;
