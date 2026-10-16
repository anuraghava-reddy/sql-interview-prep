/*
  Source     : HackerRank
  Problem    : Select By ID
  Link       : https://www.hackerrank.com/challenges/select-by-id/problem
  Difficulty : Easy
  Topic      : Basic Select (WHERE filter on primary key)
  Approach   : Select every column (*) from CITY and use WHERE to keep only
               the row whose ID equals 1661. ID is unique, so exactly one row is returned.
  Mistake    : None. Passed the sample test case on the first run.
  Learning   : Filtering on a unique ID or primary key is the quickest way to fetch one
               specific record. In real work, list the columns you need instead of
               using SELECT *.
*/

SELECT
    *
FROM CITY
WHERE ID = 1661;
