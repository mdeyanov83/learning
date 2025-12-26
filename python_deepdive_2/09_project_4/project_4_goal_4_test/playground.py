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


# # Goal 4 (Non optimized)

# cutoff_date = datetime(2017, 3, 11)

# def group_key(item):
#     return item.gender, item.vehicle_make

# data = parse_utils.filtered_iter_combined(constants.fnames,
#                                           constants.class_names,
#                                           constants.parsers,
#                                           constants.compress_fields,
#                                           key=lambda row: row.last_updated >= cutoff_date)
# sorted_data = sorted(data, key=group_key)

# # **************
# ## does not work, as tee creates a 'shallow copy'
# # groups = itertools.groupby(sorted_data, key=group_key)
# # group_1, group_2 = itertools.tee(groups, 2)

# # # Test
# # rg1 = next(group_1)
# # rg2 = next(group_2)
# # print(rg1[0], id(rg1[1]))
# # print(rg2[0], id(rg2[1]))

# # group_f = (item for item in group_1 if item[0][0] == 'Female')
# # data_f = ((item[0][1], len(list(item[1]))) for item in group_f)
# # print('Group F')
# # for row in data_f:
# #     print(row)

# # # fails, becuse the iterators for each car make are exhausted in the prvious block
# # group_m = (item for item in group_2 if item[0][0] == 'Male')
# # data_m = ((item[0][1], len(list(item[1]))) for item in group_m)
# # print('Group M')
# # for row in data_m:
# #     print(row)
# # *****************

# # Working solution
# groups_1 = itertools.groupby(sorted_data, key=group_key)
# groups_2 = itertools.groupby(sorted_data, key=group_key)

# group_f = (item for item in groups_1 if item[0][0] == 'Female')
# data_f = ((item[0][1], len(list(item[1]))) for item in group_f)
# print('Group F')
# for row in data_f:
#     print(row)

# # fails, becuse the iterators for each car make are exhausted in the prvious block
# group_m = (item for item in groups_2 if item[0][0] == 'Male')
# data_m = ((item[0][1], len(list(item[1]))) for item in group_m)
# print('Group M')
# for row in data_m:
#     print(row)


# # Goal 4 (Optimized)

# cutoff_date = datetime(2017, 3, 11)

# def group_key(item):
#     return item.vehicle_make

# data = parse_utils.filtered_iter_combined(constants.fnames,
#                                           constants.class_names,
#                                           constants.parsers,
#                                           constants.compress_fields,
#                                           key=lambda row: row.last_updated >= cutoff_date)
# data_1, data_2 = itertools.tee(data, 2)

# data_m = (row for row in data_1 if row.gender == 'Male')
# sorted_data_m = sorted(data_m, key=group_key)
# groups_m = itertools.groupby(sorted_data_m, key=group_key)
# groups_m_counts = ((g[0], len(list(g[1]))) for g in groups_m)
# print('Groups M')
# for row in groups_m_counts:
#     print(row)

# print()

# data_f = (row for row in data_2 if row.gender == 'Female')
# sorted_data_f = sorted(data_f, key=group_key)
# groups_f = itertools.groupby(sorted_data_f, key=group_key)
# groups_f_counts = ((g[0], len(list(g[1]))) for g in groups_f)
# print('Groups F')
# for row in groups_f_counts:
#     print(row)


# Goal 4 (Refactored)

cutoff_date = datetime(2017, 3, 11)

def filter_key(row, cutoff_date, gender):
    return row.last_updated >= cutoff_date and row.gender == gender

results_f = parse_utils.group_data(constants.fnames,
                                   constants.class_names,
                                   constants.parsers,
                                   constants.compress_fields,
                                   filter_key=lambda row: row.last_updated >= cutoff_date and row.gender == 'Female',
                                   group_key=lambda row: row.vehicle_make)


results_m = parse_utils.group_data(constants.fnames,
                                   constants.class_names,
                                   constants.parsers,
                                   constants.compress_fields,
                                   filter_key=lambda row: row.last_updated >= cutoff_date,
                                   group_key=lambda row: row.vehicle_make)


print('Resuts F')
for row in results_f:
    print(row)

print()

print('Results M')
for row in results_m:
    print(row)
