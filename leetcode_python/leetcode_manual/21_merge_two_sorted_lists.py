from typing import Optional

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:

        head = current = ListNode()

        while list1 and list2:
            if list1.val < list2.val:
                current.next = list1

                # current = current.next
                # list1 = list1.next

                list1, current = list1.next, list1

            else:
                current.next = list2

                # current = current.next
                # list2 = list2.next

                list2, current = list2.next, list2

        if list1 or list2 :
            current.next = list1 if list1 else list2

        return head.next


# Function to convert a Python list into a linked list
def create_linked_list(values):
    if not values:
        return None
    head = ListNode(values[0])
    current = head
    for val in values[1:]:
        current.next = ListNode(val)
        current = current.next
    return head


# Function to print a linked lists (for debugging)
def print_linked_list(head):
    result = []
    while head:
        result.append(head.val)
        head = head.next
    print(" -> ".join(map(str, result)))


# Main function
def main():

    # Input lists must be sorted (ascending) for this excercise

    L1 = [1, 3, 4]
    L2 = [2, 3, 5, 6, 7]

    list1 = create_linked_list(L1)
    list2 = create_linked_list(L2)

    solution = Solution()
    merged_list = solution.mergeTwoLists(list1, list2)

    print_linked_list(merged_list)


if __name__ == "__main__":
    main()
