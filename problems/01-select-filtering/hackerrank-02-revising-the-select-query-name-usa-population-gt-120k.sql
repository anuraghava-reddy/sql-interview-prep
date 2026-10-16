/*
  Source     : HackerRank
  Problem    : Revising the Select Query II
  Question   : From the CITY table, return the NAME of American cities (COUNTRYCODE = 'USA') with a population above 120,000.
  Link       : https://www.hackerrank.com/challenges/revising-the-select-query-2/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select only the NAME column from CITY and filter with COUNTRYCODE = 'USA' AND POPULATION > 120000.
  Mistake    : None
  Learning   : Same filter pattern as Select Query I, but the SELECT list changes the output. Return only the columns asked for.
*/
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;
