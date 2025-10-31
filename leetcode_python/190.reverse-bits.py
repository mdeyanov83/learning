#
# @lc app=leetcode id=190 lang=python3
#
# [190] Reverse Bits
#

# @lc code=start
class Solution:
    def reverseBits(self, n: int) -> int:
        bin = f'{n:032b}'
        bin_reversed = bin[::-1]
        return int(bin_reversed, 2)


# Using bit manipulation
# class Solution:
#     def reverseBits(self, n):
#         result = 0
#         for _ in range(32):
#             result <<= 1        # Shift result left to make space for next bit (places 0 as last bit)
#             result |= n & 1     # Copy the last bit of n into result (last bit becomes 0 OR last bit of n)
#             n >>= 1             # Shift n right and discard least significant bit
#         return result


# @lc code=end
