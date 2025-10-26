#
# @lc app=leetcode id=145 lang=python3
#
# [145] Binary Tree Postorder Traversal
#

# @lc code=start
# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

from typing import Optional, List

class Solution:
    def postorderTraversal(self, root: Optional[TreeNode]) -> List[int]:
        path = []

        def walk(node: Optional[TreeNode]):
            if not node:
                return

            walk(node.left)
            walk(node.right)
            path.append(node.val)

        walk(root)

        return path

# @lc code=end

