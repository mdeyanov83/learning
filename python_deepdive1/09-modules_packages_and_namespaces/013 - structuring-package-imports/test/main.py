import shared.validators


shared.validators.is_boolean('True')
shared.validators.json.is_json('{}')
shared.validators.is_numeric(10)
shared.validators.is_date('2008-01-01')

shared.validators.boolean.is_boolean(True)


print('\n\n****** self ******')
for k in dict(globals()).keys():
    print(k)


print('\n\n****** shared ******')
for k in shared.__dict__.keys():
    print(k)


print('\n\n****** validators ******')
for k in shared.validators.__dict__.keys():
    print(k)


print('\n\n****** numeric ******')
for k in shared.validators.numeric.__dict__.keys():
    print(k)
