import constants
import parse_utils
import itertools
from datetime import datetime


# for fname, class_name, parser in zip(constants.fnames, constants.class_names, constants.parsers):
#     file_iter = parse_utils.iter_file(fname, class_name, parser)

#     print(fname)
#     for _ in range(3):
#         print(next(file_iter))
#     print()


# gen = parse_utils.iter_combined_plain_tuple(constants.fnames,
#                                             constants.class_names,
#                                             constants.parsers,
#                                             constants.compress_fields)
# print(list(next(gen)))
# print(list(next(gen)))


# nt = parse_utils.create_combo_named_tuple_class(
#     constants.fnames, constants.compress_fields)
# print(nt._fields)


# # Goal 2
# data_iter = parse_utils.iter_combined(constants.fnames,
#                                       constants.class_names,
#                                       constants.parsers,
#                                       constants.compress_fields)
# for row in itertools.islice(data_iter, 5):
#     print(row)


# # Goal 3
# cutoff_date = datetime(2017, 3, 11)
# data = parse_utils.filtered_iter_combined(constants.fnames,
#                                           constants.class_names,
#                                           constants.parsers,
#                                           constants.compress_fields,
#                                           key=lambda row: row.last_updated >= cutoff_date)
# for row in data:
#     print(row)


# Goal 4

cutoff_date = datetime(2017, 3, 11)

def group_key(item):
    return item.gender, item.vehicle_make

data = parse_utils.filtered_iter_combined(constants.fnames,
                                          constants.class_names,
                                          constants.parsers,
                                          constants.compress_fields,
                                          key=lambda row: row.last_updated >= cutoff_date)

sorted_data = sorted(data, key=group_key)
groups = itertools.groupby(sorted_data, key=group_key)
group_1, group_2 = itertools.tee(groups, 2)

rg1 = next(group_1)
rg2 = next(group_2)
print(rg1[0], id(rg1[1]))
print(rg2[0], id(rg2[1]))

# group_f = (item for item in group_1 if item[0][0] == 'Female')
# data_f = ((item[0][1], len(list(item[1]))) for item in group_f)
# print('Group F')
# for row in data_f:
#     print(row)

# group_m = (item for item in group_2 if item[0][0] == 'Male')
# data_m = ((item[0][1], len(list(item[1]))) for item in group_m)
# print('Group M')
# for row in data_m:
#     print(row)
