import argparse
import datetime

parser = argparse.ArgumentParser(description='Returns a string containing the name and age of the person')

parser.add_argument('-f', '--first', help='first name', type=str, required=False, dest='first_name')
parser.add_argument('-l', '--last', help='last name', type=str, required=True, dest='last_name')
parser.add_argument('--yob', help='year of birt', type=int, required=False, dest='birth_year')
args = parser.parse_args()

