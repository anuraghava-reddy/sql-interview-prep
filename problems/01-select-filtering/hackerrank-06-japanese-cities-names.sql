/*
  Source     : HackerRank
  Problem    : Japanese Cities' Names
  Link       : https://www.hackerrank.com/challenges/japanese-cities-name/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select only the NAME column from CITY and filter rows where COUNTRYCODE = 'JPN'.
  Mistake    : None
  Learning   : Select only the columns the question asks for. A correct WHERE filter still fails if the SELECT list is wrong.
*/
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'JPN';
