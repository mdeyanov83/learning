#
# @lc app=leetcode id=168 lang=python3
#
# [168] Excel Sheet Column Title
#

# @lc code=start
class Solution:
    def convertToTitle(self, columnNumber: int) -> str:

        if columnNumber == 1: return 'A'

        digits = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        base = 26
        digits = []
        n = columnNumber - 1

        while n > 0:
            n, m = divmod(n, base)
            digits.insert(0, m)

        
        return result


# @lc code=end

