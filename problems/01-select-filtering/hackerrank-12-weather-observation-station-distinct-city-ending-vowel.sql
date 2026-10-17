/*
  Source     : HackerRank
  Problem    : Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-7/problem
  Difficulty : Easy
  Topic      : Basic Select (String Functions, IN, DISTINCT)
  Approach   : RIGHT(CITY, 1) takes the last character, LOWER() handles case, and IN checks it against the five vowels. DISTINCT removes duplicate city names.
  Mistake    : None. It passed the sample test cases on the first run.
  Learning   : RIGHT(col, 1) gets the last character, the mirror of LEFT(col, 1) from Station 6. Wrapping it in LOWER() keeps the match case-safe.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(RIGHT(CITY, 1)) IN ('a', 'e', 'i', 'o', 'u');
