from collections import namedtuple
from datetime import datetime


FILE_NAME = 'nyc_parking_tickets_extract.csv'


def cast(field_name, value):
    if 'date' in field_name.lower():
        return datetime.strptime(value, "%m/%d/%Y").date()
    elif 'number' in field_name.lower() or 'code' in field_name.lower():
        return int(value)
    else:
        return str(value)


def cast_row(headers, data_row):
    return [cast(field_name, value)
            for field_name, value in zip(headers, data_row)]


def get_data(FILE):
    with open(FILE) as f:
        headers = next(f).strip('\n').replace(' ', '_').split(',')
        Violation = namedtuple('Violation', headers)

        for data_row in f:
            data_row = data_row.strip('\n').split(',')
            cast_data_row = cast_row(headers, data_row)
            violation = Violation(*cast_data_row)
            yield violation


def main():
    data = get_data(FILE_NAME)

    for _ in range(10):
        print(next(data))


if __name__ == "__main__":
    main()

# Summons Number,Plate ID,Registration State,Plate Type,Issue Date,Violation Code,Vehicle Body Type,Vehicle Make,Violation Description
# 4006478550,VAD7274,VA,PAS,10/5/2016,5,4D,BMW,BUS LANE VIOLATION
# 4006462396,22834JK,NY,COM,9/30/2016,5,VAN,CHEVR,BUS LANE VIOLATION
