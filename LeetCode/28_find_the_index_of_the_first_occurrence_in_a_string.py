class Solution:
    def strStr(self, haystack: str, needle: str) -> int:

        for i in range(len(haystack)):
            if haystack[i:i+len(needle)] == needle:
                return i
        return -1




def main():
    sol = Solution()

    haystack = "hello"
    needle = "ll"

    print(sol.strStr(haystack, needle))


if __name__ == "__main__":
    main()
