import constants

# See a sample of what is in each file
print()
for fname in constants.fnames:
    print(fname)
    with open(fname) as f:
        print(next(f), end='')
        print(next(f), end='')
        print(next(f), end='')
    print()
