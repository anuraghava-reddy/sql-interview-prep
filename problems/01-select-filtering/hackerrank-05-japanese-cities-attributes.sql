/*
  Source     : HackerRank
  Problem    : Japanese Cities' Attributes
  Link       : https://www.hackerrank.com/challenges/japanese-cities-attributes/problem
  Difficulty : Easy
  Topic      : Basic Select (WHERE filter on a text column)
  Approach   : Select every column (*) from CITY and use WHERE to keep only
               the rows whose COUNTRYCODE is 'JPN'. Unlike filtering by ID,
               this can return many rows.
  Mistake    : None. Passed the sample test case on the first run.
  Learning   : Put text values in single quotes ('JPN'). Filtering on a column
               that isn't unique returns every row that matches, not just one.
*/

SELECT
    *
FROM CITY
WHERE COUNTRYCODE = 'JPN';
