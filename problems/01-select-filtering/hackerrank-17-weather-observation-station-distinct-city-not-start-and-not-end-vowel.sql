/*
  Source     : HackerRank
  Problem    : Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-12/problem
  Difficulty : Easy
  Topic      : Basic Select (String Functions, NOT IN, AND)
  Approach   : LEFT(CITY, 1) and RIGHT(CITY, 1) pull the first and last letters. LOWER makes the check case-insensitive.
               NOT IN ('a','e','i','o','u') flags a non-vowel. AND keeps a city only if both ends are non-vowels.
               DISTINCT removes duplicates.
  Mistake    : None. The only real trap is using OR, which keeps a city if either end is a non-vowel.
               That's Weather Observation Station 11.
  Learning   : Station 11 and Station 12 differ by a single operator. "Either...or" means OR, and "and" in
               "not start AND not end" means both conditions must hold.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(LEFT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u')
  AND LOWER(RIGHT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');
