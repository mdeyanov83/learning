from datetime import datetime

class Solution:
    def maxOperations(self, s: str) -> int:

        lst = list(s)
        n = len(lst)
        count = 0
        start = 0
        end = n-1

        while True:
            acted = False
            started = False
            for i in range(start, end):
                if lst[i] == '1' and not started:
                    start = i
                    started = True
                if lst[i] == '1' and lst[i+1] == '0':

                    # Walk the list from current "1" to last trailing 1 or end of list and swap.
                    for j in range(i + 1, n):
                        if j == n-1 or lst[j+1] == '1':
                            lst[i], lst[j] = lst[j], lst[i]
                            end = j
                            count += 1
                            acted = True
                            break

                    # print(f"{start=}, {count=}, {i=}", lst)


            if not acted:
                break

        return count


def main():
    sol = Solution()
    input = "1001101"
    print(sol.maxOperations(input))


if __name__ == "__main__":
    main()
