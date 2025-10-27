--
-- @lc app=leetcode id=181 lang=mysql
--
-- [181] Employees Earning More Than Their Managers
--

-- @lc code=start
# Write your MySQL query statement below

SELECT e.name AS Employee from Employee e JOIN Employee m WHERE e.managerId = m.id AND e.salary > m.salary


-- @lc code=end

