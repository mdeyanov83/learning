from collections import namedtuple


FILE_NAME = 'nyc_parking_tickets_extract.csv'

# def cast_row(data_types, data_row)

def cast(field_name, value):
    if 

def parse_data():
    with open(FILE_NAME) as f:

        field_names = next(f).strip('\n').replace(' ', '_').split(',')
        Violation = namedtuple('Violation', field_names)


        print(Violation)
        print(field_names)

        print(next(f).strip('\n'))
        print(next(f).strip('\n'))
        print(next(f).strip('\n'))


def main():
    parse_data()


if __name__ == "__main__":
    main()

# Summons Number,Plate ID,Registration State,Plate Type,Issue Date,Violation Code,Vehicle Body Type,Vehicle Make,Violation Description
# 4006478550,VAD7274,VA,PAS,10/5/2016,5,4D,BMW,BUS LANE VIOLATION
# 4006462396,22834JK,NY,COM,9/30/2016,5,VAN,CHEVR,BUS LANE VIOLATION
