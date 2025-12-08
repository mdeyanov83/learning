print('========================================')

print(f'Running main.py - module name: {__name__}')

import module1
import sys


print(module1)

module1.pprint_dict('main.globals', globals())



print('========================================')
