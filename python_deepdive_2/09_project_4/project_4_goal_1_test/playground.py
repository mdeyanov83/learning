import constants
import parse_utils


# for fname, class_name, parser in zip(constants.fnames, constants.class_names, constants.parsers):
#     file_iter = parse_utils.iter_file(fname, class_name, parser)

#     print(fname)
#     for _ in range(3):
#         print(next(file_iter))
#     print()


gen = parse_utils.iter_combined_plain_tuple(constants.fnames,
                                            constants.class_names,
                                            constants.parsers,
                                            constants.compress_fields)

print(list(next(gen)))
print(list(next(gen)))
print(list(next(gen)))
