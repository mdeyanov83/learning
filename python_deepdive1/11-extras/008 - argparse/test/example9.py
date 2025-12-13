import argparse

parser = argparse.ArgumentParser(description='testing defaults and flags')

parser.add_argument('--monty', action='store_const', const='Python')
parser.add_argument('-n', '--name', default='John')


args = parser.parse_args()

print(args)
