/*
  Source     : HackerRank
  Problem    : Find the difference between the total number of CITY entries in STATION and the number of distinct CITY entries.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-4/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : COUNT(CITY) counts every city entry, COUNT(DISTINCT CITY) counts each unique city once, and subtracting the two gives the number of duplicate entries.
  Mistake    : None
  Learning   : COUNT(col) counts all non-NULL values, while COUNT(DISTINCT col) counts unique non-NULL values. Their difference is the number of duplicates.
*/
SELECT
    COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;
