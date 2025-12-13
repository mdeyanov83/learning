import argparse
import cmath

parser = argparse.ArgumentParser()

group = parser.add_mutually_exclusive_group()
group.add_argument('-v', '--verbose', action='store_true')
group.add_argument('-q', '--quiet', action='store_true')

parser.add_argument('-n', type=complex, required=True)

args = parser.parse_args()

print(args)

if args.quiet:
    print('quite mode...')
    print('nothing to see here. move along now...')
elif args.verbose:
    print('verbose mode...')
    print(f'input: {args.n}')
    print(f're={args.n.real} im={args.n.imag}')
    print(f'{args.n} = {cmath.polar(args.n)}')
else:
    print('normal mode...')
    print(f'{args.n} = {cmath.polar(args.n)}')
