import common # imported so we can see the common.__dict__ property
import common.validators as validators
import common.models as models
import common.models.posts.post
import common.models.posts.posts
import common.models.users.user


validators.is_boolean('True')
validators.is_json('{}')
validators.is_numeric(10)
validators.is_date('2008-01-01')

# from common.validators import *


john_post = common.models.posts.post.Post()
john_posts = common.models.posts.posts.Posts()
john = common.models.users.user.User()


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


print('\n\n****** models ******')
for k in common.models.__dict__.keys():
    print(k)
