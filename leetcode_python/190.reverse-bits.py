#
# @lc app=leetcode id=190 lang=python3
#
# [190] Reverse Bits
#

# @lc code=start
class Solution:
    def reverseBits(self, n: int) -> int:
        # bin = f'{n:032b}'
        # bin_reversed = bin[::-1]
        # return int(bin_reversed, 2)
        return int(f'{n:032b}'[::-1])

# @lc code=end
