/*
  Source     : HackerRank
  Problem    : Select By ID
  Question   : From the CITY table, return all columns for the city with ID 1661.
  Link       : https://www.hackerrank.com/challenges/select-by-id/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select all columns from CITY and filter on the ID column with WHERE ID = 1661.
  Mistake    : None
  Learning   : Filtering on a unique ID returns exactly one row. Numbers are compared without quotes.
*/
SELECT *
FROM CITY
WHERE ID = 1661;
