import constants
import parse_utils

# See a sample of what is in each file
# print()
# for fname in constants.fnames:
#     print(fname)
#     with open(fname) as f:
#         print(next(f), end='')
#         print(next(f), end='')
#         print(next(f), end='')
#     print()

# test the csv.reader
# print()
# for fname in constants.fnames:
#     print(fname)
#     with open(fname) as f:
#         reader = csv.reader(f, delimiter=',', quotechar='"')
#         print(next(reader))
#         print(next(reader))
#     print()

# header row (field names)
for fname in constants.fnames:
    print(fname)
    reader = parse_utils.csv_parser(fname, include_header=True)
    print(next(reader))
