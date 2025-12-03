from collections import defaultdict
from typing import List
from itertools import combinations
from math import gcd, comb

class Solution:
    def countTrapezoids(self, points: List[List[int]]) -> int:

        buckets = defaultdict(list)
        midpoints = defaultdict(int)
        ans = 0
        n = len(points)

        # Hash every point pair by its reduced slope, normalized with GCD and fixed sign

        for i in range(n-1):
            for j in range(i+1, n):
                x1, y1 = points[i]
                x2, y2 = points[j]

                dy = y2 - y1
                dx = x2 - x1
                # Vertical line
                if dx == 0:
                    dy = 1
                # Horizontal line
                elif dy == 0:
                    dx = 1
                # all other cases
                else:
                    g = gcd(abs(dy), abs(dx))
                    dy //= g
                    dx //= g
                # normalize sign (dx must be positive)
                if dx < 0:
                    dy, dx = -dy, -dx

                # add point pair to slope bucket
                buckets[(dy, dx)].append((i, j))

                # calculate segment midpoint and add to midpoints dict
                mid_x = x1 + x2
                mid_y = y1 + y2
                midpoints[(mid_x, mid_y)] += 1

        for bucket in buckets.values():
             for (a, b), (c, d) in combinations(bucket, 2):
                # print(a, b, c, d, '->', len({a, b, c, d}))

                x1, y1 = points[a]
                x2, y2 = points[b]
                x3, y3 = points[c]

                # len({a, b, c, d}) == 4
                if (x3 - x1) * (y2 - y1) - (y3 - y1) * (x2 - x1) != 0:
                    ans += 1

        # print(buckets)
        # print(midpoints)

        for val in midpoints.values():
            if val >= 2:
                ans -= val // 2

        return ans

def main():
    sol = Solution()
    input = [[71,-89],[-75,-89],[-9,11],[-24,-89],[-51,-89],[-77,-89],[42,11]]

    # [[71,-89],[-75,-89],[-9,11],[-24,-89],[-51,-89],[-77,-89],[42,11]] -> 10
    # [[83,-25],[74,11],[-65,-25],[33,-25],[17,-25],[1,30],[-84,-25],[1,-25],[1,-92],[-87,13]] -> 0
    # [[92,100],[-4,55],[92,-87],[92,-91],[92,-30],[27,45],[66,82],[92,79],[92,-89],[-4,95],[92,-70],[-10,-18]] -> 21

    print(sol.countTrapezoids(input))


if __name__ == "__main__":
    main()
