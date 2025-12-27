--
-- @lc app=leetcode id=175 lang=mysql
--
-- [175] Combine Two Tables
--

-- @lc code=start
# Write your MySQL query statement below

SELECT firstName, lastName, city, state FROM Person LEFT OUTER JOIN Address on Address.personID = Person.personID

-- @lc code=end

