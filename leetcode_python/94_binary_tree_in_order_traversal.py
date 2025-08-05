from typing import Optional, List

# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

# Recursive approach (quite trivial)
class Solution:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        res = []
        def dfs(node):
            if not node:
                return
            dfs(node.left)
            res.append(node.val)
            dfs(node.right)
        dfs(root)
        return res

# Iterative approach (more difficult)
class SolutionIterative:
    def inorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        res = []
        stack = []
        while root or stack:
            while root:
                stack.append(root)
                root = root.left
            root = stack.pop()
            res.append(root.val)
            root = root.right
        return res


def main():
    sol = Solution()
    solIter = SolutionIterative()

    # root = [1,2,3,4,5,null,8,null,null,6,7,9]
    inputTree = TreeNode(1, TreeNode(2, TreeNode(4), TreeNode(5, TreeNode(6), TreeNode(7))), TreeNode(3, None, TreeNode(8, TreeNode(9))))

    print(sol.inorderTraversal(inputTree))

    print(solIter.inorderTraversal(inputTree))



if __name__ == "__main__":
    main()






