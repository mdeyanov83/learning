from collections import Counter




nums = [1, 1, 2, 2, 1, 3, 3, 4, 5, 1, 2, 3, 3]

str = 'aabbbcaaccjjjseeccabbbccbbbbbbxxx'
count = Counter(str)

print(count.values())

sort = sorted(count.items(), key=lambda x: x[1], reverse=True)


print(sort)
