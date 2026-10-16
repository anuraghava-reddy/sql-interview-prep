/*
  Source     : HackerRank
  Problem    : Query a list of CITY and STATE from the STATION table.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-1/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select only the CITY and STATE columns from the STATION table, with no filter, so every row is returned.
  Mistake    : None
  Learning   : List multiple columns in SELECT separated by commas to return only the fields you need.
*/
SELECT
    CITY,
    STATE
FROM STATION;
