from typing import List

class Solution:
    def generate(self, numRows: int) -> List[List[int]]:

        if numRows == 1:
            return [[1]]

        rows = [[1], [1, 1]]

        for i in range(2, numRows):
            newRow = [1]
            for j in range(1, i):
                newRow.append(rows[i-1][j-1] + rows[i-1][j])
            newRow.append(1)

            rows.append(newRow)
        return rows


def main():
    input = 5
    sol = Solution()
    print(sol.generate(input))


if __name__ == "__main__":
    main()
