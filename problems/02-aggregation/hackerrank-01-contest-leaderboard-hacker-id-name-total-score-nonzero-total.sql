/*
  Source     : HackerRank
  Problem    : The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.
  Link       : https://www.hackerrank.com/challenges/contest-leaderboard/problem
  Difficulty : Medium
  Topic      : Aggregation
  Approach   : Join Submissions with Hackers, take MAX(score) per hacker per challenge in a derived table,
               then SUM those maximums per hacker, drop zero totals with HAVING, and sort by total DESC, hacker_id ASC.
  Mistake    : Referenced inner aliases s and h outside their subquery; left name out of the GROUP BY.
  Learning   : An alias only exists inside its own query level, so outer levels must use the derived table's alias.
               Every non-aggregated column in SELECT must be in GROUP BY. "Total" here means a sum of maximums, not a plain sum.
*/

SELECT 
    t.hacker_id,
    t.name,
    SUM(t.max_score) AS total_score
FROM (
    SELECT
        m.hacker_id,
        m.name,
        m.challenge_id,
        MAX(m.score) AS max_score
    FROM (
        SELECT s.hacker_id, h.name, s.challenge_id, s.score
        FROM Submissions s
        LEFT JOIN Hackers h
          ON s.hacker_id = h.hacker_id
    ) m
    GROUP BY m.hacker_id, m.name, m.challenge_id
) t
GROUP BY t.hacker_id, t.name
HAVING SUM(t.max_score) > 0
ORDER BY total_score DESC, t.hacker_id ASC;
