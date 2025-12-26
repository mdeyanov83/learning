import csv
from datetime import datetime
from collections import namedtuple

fname_personal = 'data/personal_info.csv'




def read_data(file):
    with open(file) as f:
        reader = csv.reader(f, delimiter=',', quotechar='"')
        headers = next(reader)
        PersonalInfo = namedtuple('PersonalInfo', headers)

        for row in reader:
            personal_info = PersonalInfo(*row)
            yield personal_info


def main():
    data = read_data(fname_personal)

    for _ in range(10):
        print(next(data))


if __name__ == "__main__":
    main()
