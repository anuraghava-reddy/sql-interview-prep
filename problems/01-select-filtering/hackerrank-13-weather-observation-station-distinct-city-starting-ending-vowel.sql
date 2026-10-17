/*
  Source     : HackerRank
  Problem    : Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-8/problem
  Difficulty : Easy
  Topic      : Basic Select (String Functions, IN, AND, DISTINCT)
  Approach   : LEFT(CITY, 1) and RIGHT(CITY, 1) take the first and last characters. LOWER() makes the match case-safe, and each is checked against the vowels with IN. AND requires both conditions to be true. DISTINCT removes duplicates.
  Mistake    : None. Submitted and passed on the first try.
  Learning   : Station 6 (first letter) and Station 7 (last letter) combine here with AND. Use AND for "both ends" and OR for "either end".
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(LEFT(CITY, 1)) IN ('a', 'e', 'i', 'o', 'u')
  AND LOWER(RIGHT(CITY, 1)) IN ('a', 'e', 'i', 'o', 'u');
