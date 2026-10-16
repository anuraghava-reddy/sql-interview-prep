/*
  Source     : HackerRank
  Problem    : Revising the Select Query I
  Question   : From the CITY table, return all columns for American cities (COUNTRYCODE = 'USA') with a population above 100,000.
  Link       : https://www.hackerrank.com/challenges/revising-the-select-query/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select all columns from CITY and filter with two conditions joined by AND: COUNTRYCODE = 'USA' and POPULATION > 100000.
  Mistake    : Wrote COUNTRYCODE = USA without quotes, so the query errored.
  Learning   : Text values need single quotes ('USA'). Numbers don't (100000).
*/
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 100000;
