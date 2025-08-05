from typing import List

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        number = 0
        for i in range(0, len(nums)):
            number = number^nums[i]
        return number


def main():
    sol = Solution()

    input = [4,1,2,1,2]

    print(sol.singleNumber(input))


if __name__ == "__main__":
    main()
