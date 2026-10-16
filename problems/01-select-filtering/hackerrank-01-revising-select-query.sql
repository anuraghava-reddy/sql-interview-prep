/*
  Source     : HackerRank
  Problem    : Revising the Select Query I
  Link       : https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true
  Difficulty : Easy
  Topic      : Select & filtering
  Approach   : Select all columns from CITY and filter with WHERE on two conditions
               joined by AND: COUNTRYCODE = 'USA' and POPULATION > 100000.
  Mistake    : Wrote COUNTRYCODE = USA without quotes, so the query errored.
  Learning   : Text values need single quotes ('USA'). Numbers don't (100000).
*/

SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 100000;

