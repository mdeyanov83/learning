import argparse

parser = argparse.ArgumentParser(description='testing defaults and flags')

parser.add_argument('--monty', action='store')

args = parser.parse_args()

print(args)
