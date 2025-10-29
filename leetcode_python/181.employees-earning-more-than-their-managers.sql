--
-- @lc app=leetcode id=181 lang=mysql
--
-- [181] Employees Earning More Than Their Managers
--

-- @lc code=start
# Write your MySQL query statement below

/*************  ✨ Windsurf Command 🌟  *************/
SELECT e.Name AS Employee
FROM Employee e
INNER JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary
SELECT e.name AS Employee from Employee e JOIN Employee m WHERE e.managerId = m.id AND e.salary > m.salary
/*******  e0b4b189-3cc9-4f8d-a0aa-1fe1bf162c06  *******/


-- @lc code=end

