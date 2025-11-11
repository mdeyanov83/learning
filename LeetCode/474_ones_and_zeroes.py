import itertools
from typing import List

# class Solution:
#     def findMaxForm(self, strs: List[str], m: int, n: int) -> int:
#         def is_valid(k):
#             for subset in itertools.combinations(counts, k):
#                 sum0, sum1 = 0, 0
#                 for el in subset:
#                     sum0 += counts[el][0]
#                     sum1 += counts[el][1]
#                 if (sum0 <= m) and (sum1 <= n):
#                     return True
#             return False

#         counts = dict()
#         length = len(strs)

#         for i in range(length):
#             ones = strs[i].count('1')
#             zeroes = len(strs[i]) - ones
#             counts[i] = {
#                 0: zeroes,
#                 1: ones
#             }

#         low = 0
#         high = length

#         while low < high:
#             mid = (low + high + 1) // 2
#             if is_valid(mid):
#                 low = mid
#             else:
#                 high = mid - 1
#         return low

class Solution:
    def findMaxForm(self, strs: List[str], m: int, n: int) -> int:

        # Convert each string to count of zeroes and ones
        counts = []
        length = len(strs)
        for i in range(length):
            ones = strs[i].count('1')
            zeroes = len(strs[i]) - ones
            counts.append((zeroes, ones))

        print(counts)

        # Initialize DP array
        dp = [[0 for j in range(n+1)] for i in range(m+1)]
        print(dp)





def main():
    sol = Solution()
    strs = ["0","11","1000","01","0","101","1","1","1","0","0","0","0","1","0","0110101","0","11","01","00","01111","0011","1","1000","0","11101","1","0","10","0111"]
    m = 9
    n = 80
    print(sol.findMaxForm(strs, m, n))


if __name__ == "__main__":
    main()
