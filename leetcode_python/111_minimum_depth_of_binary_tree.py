from typing import Optional

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        if not root.left and not root.right:
            return 1

        stack = []
        currentDepth = 1
        while True:
            currentDepth += 1
            if root.left:
                stack.append((root.left, currentDepth))
            if root.right:
                stack.append((root.right, currentDepth))

            root, currentDepth = stack.pop(0)
            if not root.left and not root.right:
                break

        return currentDepth


def main():

    sol = Solution()

    #[3,9,20,null,null,15,7]
    inputTree = TreeNode(3, TreeNode(9), TreeNode(20, TreeNode(15), TreeNode(7)))
    print(sol.minDepth(inputTree))

    #[2,null,3,null,4,null,5,null,6]
    inputTree = TreeNode(2, None, TreeNode(3, None, TreeNode(4, None, TreeNode(5, None, TreeNode(6)))))
    print(sol.minDepth(inputTree))


if __name__ == "__main__":
    main()
