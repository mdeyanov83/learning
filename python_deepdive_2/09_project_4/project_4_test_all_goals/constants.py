from parse_utils import parse_date

# Files
fname_personal = 'data/personal_info.csv'
fname_employment = 'data/employment.csv'
fname_vehicles = 'data/vehicles.csv'
fname_update_status = 'data/update_status.csv'

fnames = (fname_personal, fname_employment, fname_vehicles, fname_update_status)


# Parsers
personal_parser = (str, str, str, str, str)
employment_parser = (str, str, str, str)
vehicles_parser = (str, str, str, int)
update_status_parser = (str, parse_date, parse_date)

parsers = (personal_parser, employment_parser, vehicles_parser, update_status_parser)


# Named Tuple Names
