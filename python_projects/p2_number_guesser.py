import random

top_of_range = input("Type a number: ")

if top_of_range.isdigit():
    top_of_range = int(top_of_range)


r = random.randrange(-5, 11)
print(r)
