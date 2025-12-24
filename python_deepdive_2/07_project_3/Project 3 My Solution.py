FILE_NAME = 'nyc_parking_tickets_extract.csv'


def parse_data():
    with open(FILE_NAME) as f:
        print(next(f).strip('\n'))
        print(next(f).strip('\n'))
        print(next(f).strip('\n'))








def main():
    parse_data()


if __name__ == "__main__":
    main()
