#
# @lc app=leetcode id=168 lang=python3
#
# [168] Excel Sheet Column Title
#

# @lc code=start
class Solution:
    def convertToTitle(self, columnNumber: int) -> str:

        if columnNumber == 1: return 'A'

        digits = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        base = 26
        n_base = []
        n = columnNumber - 1

        index = 0

        while n > 0:
            n, m = divmod(n, base)
            if index == 0:
                n_base.insert(0, m)
            else:
                n_base.insert(0, m-1)
            index += 1

        result = ''.join([digits[d] for d in n_base])
        return result

# @lc code=end

def main():
    sol = Solution()
    testCase = 27

    print(sol.convertToTitle(testCase))


if __name__ == "__main__":
    main()
