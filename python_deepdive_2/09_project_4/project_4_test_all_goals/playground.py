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

# print()
# print()
# # just the data
# for fname in constants.fnames:
#     print(fname)
#     reader = parse_utils.csv_parser(fname)
#     print(next(reader))
#     print(next(reader))


# # test date parser
# reader = parse_utils.csv_parser(constants.fname_update_status)
# for _ in range(3):
#     record = next(reader)
#     # print(record[0], record[1], type(parse_utils.parse_date(record[1])), parse_utils.parse_date(record[1]))
#     record = [str(record[0]), parse_utils.parse_date(
#         record[1]), parse_utils.parse_date(record[2])]
#     print(record)
