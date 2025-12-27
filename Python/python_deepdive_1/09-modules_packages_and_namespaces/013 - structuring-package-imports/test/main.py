import common # imported so we can see the common.__dict__ property
import common.validators as validators
import common.models as models

# Generally do not import using *
# from common.validators import *  # if we want to reference the validator functions direclty
# from common.models import *  # if we want to reference models classes direclty

import common.helpers as helpers

validators.is_boolean('True')
validators.is_json('{}')
validators.is_numeric(10)
validators.is_date('2008-01-01')

john_post = models.Post()
john_posts = models.Posts()
john = models.User()


print('\n\n****** self ******')
for k in dict(globals()).keys():
    print(k)


print('\n\n****** common ******')
for k in common.__dict__.keys():
    print(k)


# print('\n\n****** validators ******')
# for k in validators.__dict__.keys():
#     print(k)


# print('\n\n****** numeric ******')
# for k in validators.numeric.__dict__.keys():
#     print(k)


# print('\n\n****** posts (package) ******')
# for k in common.models.posts.__dict__.keys():
#     print(k)


print('\n\n****** models ******')
for k in common.models.__dict__.keys():
    print(k)


calc = helpers.Calc()
print(helpers.say_hello('Python'))
print(helpers.factorial(5))


import asyncio
import email
