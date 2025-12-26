import csv
from datetime import datetime

def csv_parser(fname, *, delimiter=',', quotechar='"', include_header=False):
    with open(fname) as f:
        reader = csv.reader(f, delimiter=delimiter, quotechar=quotechar)
        if not include_header:
            next(f)
        yield from reader

def parse_date(value, *, fmt='%Y-%m-%dT%H:%M:%SZ'):
    return datetime.strptime(value, fmt)
