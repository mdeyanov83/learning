--
-- @lc app=leetcode id=181 lang=mysql
--
-- [181] Employees Earning More Than Their Managers
--

-- @lc code=start
# Write your MySQL query statement below

SELECT name FROM Employee WHERE salary >
    SELECT e1.salary FROM Employee e1 JOIN Employee e2 WHERE e1.id = e2.managerId


-- @lc code=end

