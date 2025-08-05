from typing import List

class Solution:
    def maxProfit(self, prices: List[int]) -> int:

        left = 0 # Buy index
        right = 1 # Sell index

        max_p = 0

        while right < len(prices):
            curr_p = prices[right] - prices[left]
            if prices[left] < prices[right]:
                max_p = max(curr_p, max_p)
            else:
                left = right
            right += 1

        return max_p


def main():
    sol = Solution()
    input = [3,3,5,0,0,3,1,4]

    print(sol.maxProfit(input))


if __name__ == "__main__":
    main()
