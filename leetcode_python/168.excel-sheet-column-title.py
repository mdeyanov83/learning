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
        base = 25
        result = ""
        n = columnNumber - 1

        while n > 0:
            remainder = n % base
            result = digits[remainder] + result
            n //= base

        return result


# @lc code=end

