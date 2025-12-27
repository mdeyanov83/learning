from typing import List

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        stack = []
        count = 0
        for n in nums:
            while stack and stack[-1] > n:
                stack.pop()
            if n == 0:
                continue
            if not stack or stack[-1] < n:
                count += 1
                stack.append(n)

        return count


def main():
    sol = Solution()
    input = [3,1,2,1]

    print(sol.minOperations(input))


if __name__ == "__main__":
    main()
