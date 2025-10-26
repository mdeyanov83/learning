from typing import List

class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:

        common: str = ""
        flag = True
        c = 0
        char = ""
        while flag:
            if c < len(strs[0]):
                char = strs[0][c]
            for i in range(len(strs)):
                if c == len(strs[i]) or (strs[i][c] != char):
                    flag = False
                    break
            if flag:
                common = common + char
                c += 1

        return common



def main():
    sol = Solution()

    input = ["flower","flow","flight"]
    print(sol.longestCommonPrefix(input))

    input = ["dog","racecar","car"]
    print(sol.longestCommonPrefix(input))

    input = ["ab", "a"]
    print(sol.longestCommonPrefix(input))

    input = [""]
    print(sol.longestCommonPrefix(input))



if __name__ == "__main__":
    main()
