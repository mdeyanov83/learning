from typing import List

class Solution:
    def merge(self, nums1: List[int], m: int, nums2: List[int], n: int) -> None:
        """
        Do not return anything, modify nums1 in-place instead.
        """
        index1 = 0
        added = 0

        for index2 in range(n):
            while (nums1[index1] < nums2[index2]) and index1 < m + added:
                index1 += 1
            nums1.insert(index1, nums2[index2])
            index1 += 1
            added += 1

        del nums1[m+n:]


def main():
    sol = Solution()

    nums1 = [0]
    m = 0
    nums2 = [1, 2, 3]
    n = 3

    sol.merge(nums1, m, nums2, n)
    print(nums1)


if __name__ == "__main__":
    main()
