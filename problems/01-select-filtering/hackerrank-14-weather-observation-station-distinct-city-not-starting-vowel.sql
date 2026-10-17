/*
  Source     : HackerRank
  Problem    : Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-9/problem
  Difficulty : Easy
  Topic      : Basic Select (String Functions, NOT IN, DISTINCT)
  Approach   : LEFT(CITY, 1) takes the first character and LOWER() makes the match case-safe. NOT IN keeps only cities whose first letter isn't a vowel, and DISTINCT removes duplicates.
  Mistake    : None. It passed the sample test cases on the first run.
  Learning   : NOT IN is the inverse of IN. Station 9 is Station 6 with the condition flipped, so there's no need to list the consonants.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(LEFT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');
