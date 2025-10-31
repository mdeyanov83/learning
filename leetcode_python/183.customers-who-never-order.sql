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
ON Customers.id = ORders.customerId
WHERE Orders.customerID is null;


-- @lc code=end

