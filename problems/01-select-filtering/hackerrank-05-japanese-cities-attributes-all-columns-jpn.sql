/*
  Source     : HackerRank
  Problem    : Japanese Cities' Attributes
  Question   : From the CITY table, return all columns for every city in Japan (COUNTRYCODE = 'JPN').
  Link       : https://www.hackerrank.com/challenges/japanese-cities-attributes/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select all columns from CITY and filter rows where COUNTRYCODE = 'JPN'.
  Mistake    : None
  Learning   : "Attributes" means all columns, so SELECT * fits here. Compare with Japanese Cities' Names, which asks for NAME only.
*/
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN';
