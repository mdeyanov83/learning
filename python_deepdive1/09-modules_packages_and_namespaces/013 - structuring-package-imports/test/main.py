import common # imported so we can see the common.__dict__ property
import common.validators as validators
import common.models
# from common.models import *
# from common.validators import *


validators.is_boolean('True')
validators.is_json('{}')
validators.is_numeric(10)
validators.is_date('2008-01-01')




# john_post = common.models.posts.Post()
# john_posts = common.models.Posts()
# john = common.models.User()
john_post = Post()
john_posts = Posts()
john = User()


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


