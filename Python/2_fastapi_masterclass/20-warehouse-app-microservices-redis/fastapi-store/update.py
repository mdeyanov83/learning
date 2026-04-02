import time

from main import Order, redis

key = 'refund-order'
group = 'payment'

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

        # process the message from the Warehouse API, if it exists
        if results != []:
            for result in results:
                # extract the order object from the message
                obj = result[1][0][1]

                # get the order from the database
                order = Order.get(obj['pk'])
                # update order status
                order.status = 'refunded'
                order.save()
                print(order)

    except Exception as e:
        print(str(e))
    time.sleep(3)
