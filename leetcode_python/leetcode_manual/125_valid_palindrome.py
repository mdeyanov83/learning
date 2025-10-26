import re

class Solution:
    def isPalindrome(self, s: str) -> bool:
        cleaned = re.sub(r'[^a-z0-9]', '', s.lower())
        return cleaned == cleaned[::-1]



def main():
    sol = Solution()
    
    input = "A man, nama"

    print(sol.isPalindrome(input))


if __name__ == "__main__":
    main()
