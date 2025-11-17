from typing import List

class Solution:
    def kLengthApart(self, nums: List[int], k: int) -> bool:

        current = 0
        prev = None

        for i in range(len(nums)):
            if nums[i] == 1:
                current = i
                if prev and i - prev - 1 < k:
                    return False
                else:
                    prev = current

        return True

def main():
    sol = Solution()
    nums = [1,0,1]
    k = 2
    print(sol.kLengthApart(nums, k))


if __name__ == "__main__":
    main()
