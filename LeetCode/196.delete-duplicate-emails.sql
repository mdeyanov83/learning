--
-- @lc app=leetcode id=196 lang=mysql
--
-- [196] Delete Duplicate Emails
--

-- @lc code=start
# Write your MySQL query statement below
DELETE p1
FROM person p1 JOIN person p2
ON p1.email = p2.email
AND p1.id > p2.id

-- @lc code=end

