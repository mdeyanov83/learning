import argparse
import datetime

parser = argparse.ArgumentParser(description='Returns a string containing the name and age of the person')

parser.add_argument('-f', '--first', help='first name', type=str, required=False)
parser.add_argument('-l', '--last', help='last name', type=str, required=True)
parser.add_argument('--yob', help='year of birt', type=int, required=False)
args = parser.parse_args()

print(args)
