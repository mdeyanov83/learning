import copy
import time

flat_list = [1, 2, 3, 4, 5]  # Flat object

start = time.time()
for _ in range(10**6):
    copy.copy(flat_list)
print("Shallow copy time:", time.time() - start)

start = time.time()
for _ in range(10**6):
    copy.deepcopy(flat_list)
print("Deep copy time:", time.time() - start)
