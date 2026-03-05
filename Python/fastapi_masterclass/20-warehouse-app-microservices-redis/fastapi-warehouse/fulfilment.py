import time

from main import Product, redis

key = 'order-completed'
group = 'warehouse-group'

# create the group, if not created
try:
    redis.xgroup_create(
        name=key,
        groupname=group,
        mkstream=True,
    )
    print('Group created')
except Exception as e:
    print(str(e))

while True:
    try:
        results = redis.xreadgroup(
            groupname=group,
            consumername=key,
            streams={key: '>'},  # intercept all streams
        )
        print(results)

        # process the message from the Store API, if it exists
        if results != []:
            for result in results:
                # extract the order object from the message
                obj = result[1][0][1]
                try:
                    # get the product from the database
                    product = Product.get(obj['product_id'])
                    # amend qty by the ordered qty
                    product.quantity -= int(obj['quantity'])
                    # save the product in the database
                    product.save()
                    print(product)
                except Exception:
                    # send a message back to the store if product does not exist
                    redis.xadd(name='refund-order', fields=obj)

    except Exception as e:
        print(str(e))
    time.sleep(3)
