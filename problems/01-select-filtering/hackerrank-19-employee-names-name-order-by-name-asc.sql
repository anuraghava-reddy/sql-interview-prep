/*
  Source     : HackerRank
  Problem    : Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
  Link       : https://www.hackerrank.com/challenges/name-of-employees/problem
  Difficulty : Easy
  Topic      : Basic Select (ORDER BY)
  Approach   : SELECT name returns the employee names. ORDER BY name sorts them alphabetically
               (ascending is the default).
  Mistake    : None. Adding DISTINCT would be a mistake here: names repeat (e.g. David, Dorothy), and the
               expected output keeps the duplicates.
  Learning   : ORDER BY sorts ascending (A-Z) by default, so ASC is optional. Only remove duplicates when the
               problem asks for it.
*/

SELECT name
FROM Employee
ORDER BY name;
