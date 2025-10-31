--
-- @lc app=leetcode id=183 lang=mysql
--
-- [183] Customers Who Never Order
--

-- @lc code=start
# Write your MySQL query statement below


SELECT name as Customers
FROM Customers
LEFT JOIN Orders
ON Customers.id = Orders.customerId
UNION
SELECT
FROM Customers
RIGHT JOIN Orders
ON Customers.id = Orders.customerId
WHERE Orders.customerId is NULL;


-- @lc code=end

