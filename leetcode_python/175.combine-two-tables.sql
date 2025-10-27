--
-- @lc app=leetcode id=175 lang=mysql
--
-- [175] Combine Two Tables
--

-- @lc code=start
# Write your MySQL query statement below

SELECT * FROM Person JOIN Address on Person.personID = Address.personID SHOW firstName, lastName, city, state

-- @lc code=end

