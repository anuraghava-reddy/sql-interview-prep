/*
  Source     : HackerRank
  Problem    : Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
  Link       : https://www.hackerrank.com/challenges/weather-observation-station-10/problem
  Difficulty : Easy
  Topic      : Basic Select
  Approach   : RIGHT(CITY, 1) takes the last character and LOWER() makes the check case-insensitive.
               NOT IN ('a','e','i','o','u') keeps only cities whose last letter is not a vowel.
               DISTINCT removes duplicate city names.
  Mistake    : None. Passed on the first submission.
  Learning   : This is the reverse of Station 7. Changing IN to NOT IN flips the filter.
               Use LOWER() so uppercase letters still match the vowel list.
*/

SELECT DISTINCT CITY
FROM STATION
WHERE LOWER(RIGHT(CITY, 1)) NOT IN ('a', 'e', 'i', 'o', 'u');
