/*
  Source     : HackerRank
  Problem    : Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
  Link       : https://www.hackerrank.com/challenges/salary-of-employees/problem
  Difficulty : Easy
  Topic      : Basic Select (WHERE with AND, ORDER BY)
  Approach   : WHERE salary > 2000 AND months < 10 keeps employees who earn more than $2000 a month and have
               worked fewer than 10 months. ORDER BY employee_id ASC sorts them by ID.
  Mistake    : None.
  Learning   : Use AND when a row must meet every condition. Match each comparison sign to the problem's
               wording: "greater than" is >, "less than" is <.
*/

SELECT name
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;
