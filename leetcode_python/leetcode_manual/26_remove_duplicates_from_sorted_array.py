from typing import List

class Solution:
    def removeDuplicates(self, nums: List[int]) -> int:

        k = 0

        for i in range(1, len(nums)):
            if nums[k] < nums[i]:
                k += 1
                nums[k] = nums[i]

        return k+1



def main():
    sol = Solution()

    input = [1,1,2]
    print(sol.removeDuplicates(input))
    print(input)

    input = [0,0,1,1,1,2,2,3,3,4]
    print(sol.removeDuplicates(input))
    print(input)



if __name__ == "__main__":
    main()

