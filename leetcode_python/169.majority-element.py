#
# @lc app=leetcode id=169 lang=python3
#
# [169] Majority Element
#

from typing import List

# @lc code=start
class Solution:
    def majorityElement(self, nums: List[int]) -> int:

        occur = {}

        for x in nums:
            if x in occur:
                occur[x] += 1
            else:
                occur[x] = 1

        for key in occur:
            if key >= len(nums) / 2:
                return key

# @lc code=end

def main():
    sol = Solution()

    input = [2,2,1,1,1,2,2]

    print(sol.majorityElement(input))

if __name__ == "__main__":
    main()
