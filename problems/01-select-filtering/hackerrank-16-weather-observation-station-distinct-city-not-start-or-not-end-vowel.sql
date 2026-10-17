/*
  Source     : HackerRank
  Problem    : Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-11/problem
  Difficulty : Easy
  Topic      : Basic Select (String Functions, NOT IN, OR)
  Approach   : LEFT(CITY, 1) and RIGHT(CITY, 1) pull the first and last letters. LOWER makes the check case-insensitive.
               NOT IN ('a','e','i','o','u') flags a non-vowel. OR keeps a city if either end is a non-vowel.
               DISTINCT removes duplicates.
  Mistake    : None. Solved on the first submit. The easy slip here is using AND, which matches only cities
               where both ends are non-vowels (that's Weather Observation Station 12).
  Learning   : "Not (starts with a vowel AND ends with a vowel)" is the same as "doesn't start with a vowel OR
               doesn't end with a vowel" (De Morgan's law). Read "either...or" in the problem as OR.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(LEFT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u')
   OR LOWER(RIGHT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');
