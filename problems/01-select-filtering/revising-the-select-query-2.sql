/*
  Source     : HackerRank
  Problem    : Revising the Select Query II
  Link       : https://www.hackerrank.com/challenges/revising-the-select-query-2/problem?isFullScreen=true
  Difficulty : Easy
  Topic      : Select & filtering
  Approach   : Select only the NAME column from CITY and filter with WHERE on two
               conditions joined by AND: COUNTRYCODE = 'USA' and POPULATION > 120000.
  Mistake    : None. Passed on the first run.
  Learning   : Name the column you need (SELECT NAME) instead of SELECT * when
               the problem asks for one field.
*/

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
  AND POPULATION > 120000;
