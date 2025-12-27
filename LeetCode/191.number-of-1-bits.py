#
# @lc app=leetcode id=191 lang=python
#
# [191] Number of 1 Bits
#

# @lc code=start
class Solution:
    def hammingWeight(self, n: int) -> int:
        return n.bit_count()

# @lc code=end

