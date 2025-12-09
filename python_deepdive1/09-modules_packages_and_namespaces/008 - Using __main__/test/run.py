# run.py

import timing
code = '[x**3 for x in range(1_000)]'
print(code)
result = timing.timeit(code, 10)
print(result)
