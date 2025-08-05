from typing import List

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        carryover = True
        index = len(digits) - 1
        while carryover and index >= -1:
            if index == -1:
                digits.insert(0, 1)
                break
            if digits[index] < 9:
                carryover = False
            digits[index] = (digits[index] + 1) % 10
            index -= 1

        return digits


def main():
    sol = Solution()

    input = [1,2,3]
    print(sol.plusOne(input))

    input = [4,3,2,1]
    print(sol.plusOne(input))

    input = [9]
    print(sol.plusOne(input))


if __name__ == "__main__":
    main()
