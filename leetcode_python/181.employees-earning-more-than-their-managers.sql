--
-- @lc app=leetcode id=181 lang=mysql
--
-- [181] Employees Earning More Than Their Managers
--

-- @lc code=start
# Write your MySQL query statement below

SELECT name FROM Employee WHERE salary >
    SELECT salary FROM Employee JOIN Emplo


-- @lc code=end

