#
# @lc app=leetcode id=144 lang=python3
#
# [144] Binary Tree Preorder Traversal
#

# @lc code=start
# Definition for a binary tree node.

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

from typing import List, Optional

class Solution:
    def preorderTraversal(self, root: Optional[TreeNode]) -> List[int]:

        def walk(curr: Optional[TreeNode], path: List[int]) -> List[int]:
            if not curr:
                return path
            path.append(curr.val)
            walk(curr.left, path)
            walk(curr.right, path)
            return path

        return walk(root, [])


# @lc code=end

