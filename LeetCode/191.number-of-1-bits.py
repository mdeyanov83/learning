#
# @lc app=leetcode id=191 lang=python
#
# [191] Number of 1 Bits
#

# @lc code=start
class Solution(object):
    def hammingWeight(self, n: int):
        """
        :type n: int
        :rtype: int
        """
        return n.bit_count()

# @lc code=end

