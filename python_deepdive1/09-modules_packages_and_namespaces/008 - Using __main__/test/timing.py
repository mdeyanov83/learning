# timing.py

"""
Times how long a snippet of code takes to run
over multiple iterations
"""

from time import perf_counter
from collections import namedtuple

Timing = namedtuple = ('Timing', 'repeats elapsed average')

def timeit(code, repeats=10):
    code = compile(code, filename='<string>', mode='exec')
    start = perf_counter()

    





    end = perf_counter()
