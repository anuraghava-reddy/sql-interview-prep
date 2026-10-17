/*
  Source     : HackerRank
  Problem    : Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-6/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : LOWER(CITY) turns the city name into lowercase so the check ignores case.
               SUBSTRING(..., 1, 1) takes the first letter, and IN ('a','e','i','o','u')
               keeps only the cities that start with a vowel.
  Mistake    : None
  Learning   : Use SUBSTRING(column, 1, 1) to get the first character, and LOWER() so the match
               ignores case. IN () is cleaner than chaining several OR conditions.
*/

SELECT
CITY
FROM STATION
WHERE SUBSTRING(LOWER(CITY),1,1) IN('a','e','i','o','u');
