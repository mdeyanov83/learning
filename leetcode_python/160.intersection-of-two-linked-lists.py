#
# @lc app=leetcode id=160 lang=python3
#
# [160] Intersection of Two Linked Lists
#

# @lc code=start
# Definition for singly-linked list.
class ListNode:
    def __init__(self, x):
        self.val = x
        self.next = None

from typing import Optional

# class Solution:
#     def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:

#         walkA = headA

#         while walkA:
#             walkB = headB
#             while walkB:
#                 if walkA == walkB:
#                     return walkA
#                 walkB = walkB.next
#             walkA = walkA.next
#         return

class Solution:
    def getIntersectionNode(self, headA: ListNode, headB: ListNode) -> Optional[ListNode]:

        walkA = headA
        list1 = []
        while walkA:
            list1.append(walkA)
            walkA = walkA.next
        walkB = headB

        while walkB:
            if walkB in list1:
                return walkB
            walkB = walkB.next

        return


# @lc code=end

