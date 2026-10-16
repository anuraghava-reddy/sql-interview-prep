/*
  Source     : HackerRank
  Problem    : Query the two cities in STATION with the shortest and longest CITY names, and their lengths. If there is a tie, choose the one that comes first alphabetically.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-5/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : Two separate queries. Sort by LENGTH(CITY) ascending (then CITY A–Z) and take the top row for the shortest; sort by LENGTH(CITY) descending (then CITY A–Z) and take the top row for the longest.
  Mistake    : Used SQL Server syntax in MySQL (LEN() and TOP 1), put MIN()/MAX() inside WHERE, returned only CITY without its length, and didn't handle ties alphabetically.
  Learning   : MySQL uses LENGTH() and LIMIT 1 at the end; SQL Server uses LEN() and TOP 1 after SELECT. Never mix the two. Aggregates can't be used in WHERE because WHERE runs before aggregation. ORDER BY on multiple columns breaks ties.
*/
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY), CITY
LIMIT 1;

SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1;
