/*
  Source     : HackerRank
  Problem    : Query a list of CITY names from STATION for cities with an even ID number. Print in any order, but exclude duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-3/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Select distinct CITY names from STATION and keep only rows with an even ID using MOD(ID, 2) = 0.
  Mistake    : Knew the even-number logic but couldn't recall the SQL function for the remainder.
  Learning   : MOD(a, b) returns the remainder of a ÷ b, so MOD(ID, 2) = 0 filters even values. T-SQL has no MOD(), so use ID % 2 = 0 there. DISTINCT removes duplicate values.
*/
SELECT DISTINCT CITY
FROM STATION
WHERE MOD(ID, 2) = 0;
