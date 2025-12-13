import argparse

parser = argparse.ArgumentParser()

group = parser.add_mutually_exclusive_group()
group.add_argument('-v', '--verbose', action='store_true')
group.add_argument('-q', '--quiet', action='store_true')

parser.add_argument('-n', type=complex, required=True)

args = parser.parse_args()

print(args)
