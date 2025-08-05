class Solution:

    # Brute force solution
    # def romanToInt(self, s: str) -> int:
    #     val = 0
    #     length = len(s)
    #     i = 0
    #     while i < length:
    #         match s[i]:
    #             case "I":
    #                 if i < length-1:
    #                     match s[i+1]:
    #                         case "V":
    #                             val += 4
    #                             i += 1
    #                         case "X":
    #                             val += 9
    #                             i += 1
    #                         case _:
    #                             val += 1
    #                 else:
    #                     val += 1
    #             case "V":
    #                 val += 5
    #             case "X":
    #                 if i < length-1:
    #                     match s[i+1]:
    #                         case "L":
    #                             val += 40
    #                             i += 1
    #                         case "C":
    #                             val += 90
    #                             i += 1
    #                         case _:
    #                             val += 10
    #                 else:
    #                     val += 10
    #             case "L":
    #                 val +=50
    #             case "C":
    #                 if i < length-1:
    #                     match s[i+1]:
    #                         case "D":
    #                             val += 400
    #                             i += 1
    #                         case "M":
    #                             val += 900
    #                             i += 1
    #                         case _:
    #                             val += 100
    #                 else:
    #                     val += 100
    #             case "D":
    #                 val += 500
    #             case "M":
    #                 val += 1000
    #         i += 1
    #     return val

    # Based on the rule that Roman numerals are written from largest to smalles, with the only exception for IV, IX, XL, XC, CD, CM,
    # where the smaller prefix is subracted from the larger suffix
    def romanToInt(self, s: str) -> int:
        roman_values = {
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000
        }

        total = 0
        prev_value = 0

        for char in reversed(s):
            cur_value = roman_values[char]
            if cur_value >= prev_value:
                total += cur_value
            else:
                total -= cur_value
            prev_value = cur_value
        return total



def main():
    sol = Solution()

    input = "MCMXCIV"
    print(sol.romanToInt(input))

    input = "III"
    print(sol.romanToInt(input))



if __name__ == "__main__":
    main()
