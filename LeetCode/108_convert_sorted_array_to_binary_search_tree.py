from typing import List, Optional

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def sortedArrayToBST(self, nums: List[int]) -> Optional[TreeNode]:
        if not nums:
            return None
        middle = int((len(nums)-1) / 2)
        root = TreeNode()
        root.val = nums[middle]
        root.left = self.sortedArrayToBST(nums[:middle])
        root.right = self.sortedArrayToBST(nums[middle+1:])

        return root


def main():

    input = [-10,-3,0,5,9]
    sol = Solution()
    print(sol.sortedArrayToBST(input))


if __name__ == "__main__":
    main()
