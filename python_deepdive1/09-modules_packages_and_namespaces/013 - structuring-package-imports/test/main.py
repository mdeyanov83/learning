import common.validators.boolean
import common.validators.date
import common.validators.json
import common.validators.numeric


common.validators.json.is_json('{}')
common.validators.date.is_date('2018-01-01')


print('\n\n****** self ******')
for k in dict(globals()).keys():
    print(k)
