nums = [2, 1, 3, 4]
stack = []  # decreasing stack — top is smallest

for i, num in enumerate(nums):
    while stack and nums[stack[-1]] < num:
        idx = stack.pop()
        print(f"{nums[idx]} → next greater is {num}")
    stack.append(i)
