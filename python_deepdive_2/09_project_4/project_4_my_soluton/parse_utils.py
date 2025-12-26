import csv
from datetime import datetime
from collections import namedtuple

fname_personal = 'data/personal_info.csv'




def read_data(file):
    with open(file) as f:
        # reader = csv.reader(f, delimiter=',', quotechar='"')
        headers = next(f).strip('\n').replace(' ', '_').lower().split(',')
        print(headers)

        yield from f



def main():
    data = read_data(fname_personal)

    for _ in range(10):
        print(next(data))


if __name__ == "__main__":
    main()
