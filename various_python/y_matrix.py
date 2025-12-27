import numpy as np
from typing import List

class Solution:

    def make_y_matrix(self, n, not_y, y):
        mat = np.full((n, n), not_y, dtype=int)
        mid = n // 2
        for i in range(n):
            if i < mid:
                mat[i, i] = y           # left diagonal of Y
                mat[i, n - 1 - i] = y   # right diagonal of Y
            else:
                mat[i, mid] = y         # vertical line of Y
        return mat

    def minimumOperationsToWriteY(self, grid: List[List[int]]) -> int:

        min_operations = 9999
        n = len(grid)
        input_matrix = np.matrix(grid)

        for not_y in range(3):
            for y in range(3):
                if not_y != y:
                    y_matrix = self.make_y_matrix(n, not_y, y)
                    diff_count = np.sum(input_matrix != y_matrix)
                    if diff_count < min_operations:
                        min_operations = diff_count

        return int(min_operations)


def main():
    sol = Solution()
    input = [[1, 2, 2], [1, 1, 0], [0, 1, 0]]

    print(sol.minimumOperationsToWriteY(input))


if __name__ == "__main__":
    main()
