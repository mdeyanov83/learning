from typing import List
from itertools import islice
from collections import deque

# class Solution:
#     def getRow(self, rowIndex: int) -> List[int]:
#         if rowIndex == 0:
#             return [1]
#         if rowIndex == 1:
#             return [1,1]
#         row = [1,1]
#         newRow = row.copy()
#         for i in range(1, rowIndex):
#             for j in range(1, i+1):
#                 newRow[j] = row[j-1] + row[j]
#             newRow.append(1)
#             row = newRow.copy()
#         return row

class Solution:
    def getRow(self, rowIndex: int) -> List[int]:
        def pascal():
            yield [1]
            yield [1,1]
            row = [1,2,1]
            yield row
            while True:
                r = deque(a+b for a,b in zip(row,islice(row,1,None)))
                r.append(1)
                r.appendleft(1)
                row = r
                yield list(row)

        return next(islice(pascal(), rowIndex, None))



def main():

    sol = Solution()
    input = 4

    print(sol.getRow(input))

if __name__ == "__main__":
    main()
