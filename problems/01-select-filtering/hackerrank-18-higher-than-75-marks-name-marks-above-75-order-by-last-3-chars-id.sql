/*
  Source     : HackerRank
  Problem    : Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by 
               the last three characters of each name. If two or more students both have names ending in the same 
               last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
  Link       : https://www.hackerrank.com/challenges/more-than-75-marks/problem
  Difficulty : Easy
  Topic      : Basic Select (WHERE, ORDER BY with String Functions)
  Approach   : WHERE MARKS > 75 keeps only students who scored above 75. ORDER BY RIGHT(NAME, 3) sorts by the
               last three characters. ID breaks ties when two names end the same way (both ascending by default).
  Mistake    : None. Solved on the first submit. A common slip is using >= 75 when the problem says "higher than".
  Learning   : ORDER BY can sort on an expression like RIGHT(NAME, 3), not just a column. Add more sort keys after
               a comma to break ties.
*/

SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID;
