class Solution:
    def isValid(self, s: str) -> bool:

        reverse = {
            "(": ")",
            "[": "]",
            "{": "}"
            }

        stack = []
        for i in range(len(s)):
            if s[i] in reverse:
                stack.append(s[i])
            else:
                if len(stack) > 0 and reverse[stack.pop()] == s[i]:
                    pass
                else:
                    return False

        if stack == []:
            return True
        else:
            return False


def main():
    sol = Solution()

    input = "()"

    print(sol.isValid(input))

    input = ""
    print(sol.isValid(input))

    input = "([]})"
    print(sol.isValid(input))



if __name__ == "__main__":
    main()
