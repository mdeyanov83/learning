# helpers

from .calculator import Calc


# Generally do not use functional code inside a package __init__.py
# Refactor into its own module

def say_hello(name):
    return f'Hello {name}'

def factorial(n):
    if n <= 1:
        return 1
    else:
        return n * factorial(n-1)
