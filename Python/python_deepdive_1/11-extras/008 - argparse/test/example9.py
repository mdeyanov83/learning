import argparse

parser = argparse.ArgumentParser(description='testing defaults and flags')

# parser.add_argument('--monty', action='store_const', const='Python')
# parser.add_argument('-n', '--name', default='John')
# parser.add_argument('-v', '--verbose', action='store_const', const=True, default=False)
# parser.add_argument('-v2', action='store_const', const=True)

parser.add_argument('-q', '--quiet', action='store_true')
parser.add_argument('-q2', action='store_const', const=True, default=False)

args = parser.parse_args()


print(args)
