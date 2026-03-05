import time

import requests
from fastapi import FastAPI
from fastapi.background import BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from redis_om import HashModel, get_redis_connection

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=['http://localhost:3000'],
    allow_methods=['*'],
    allow_headers=['*'],
)

redis = get_redis_connection(
    host='redis-15506.c328.europe-west3-1.gce.cloud.redislabs.com',  # redis cloud database
    port=15506,  # redis cloud database host port
    password='',  # database password
    decode_responses=True,
)


class ProductOrder(HashModel, index=True):
    product_id: str
    quantity: int

    class Meta:
        database = redis


class Order(HashModel, index=True):
    product_id: str
    price: float
    fee: float
    total: float
    quantity: int
    status: str

    class Meta:
        database = redis


@app.post('/orders')
def create(productOrder: ProductOrder, background_tasks: BackgroundTasks):
    req = requests.get(f'http://localhost:8000/product/{productOrder.product_id}')
    product = req.json()
    fee = product['price'] * 0.2
    order = Order(
        product_id=productOrder.product_id,
        price=product['price'],
        fee=fee,
        total=product['price'] + fee,
        quantity=productOrder.quantity,
        status='pending',
    )
    order.save()
    # Executing as a background task
    background_tasks.add_task(order_complete, order)
    return order


@app.get('/orders/{pk}')
def get(pk: str):
    return format(pk)


def format(pk: str):
    order = Order.get(pk)
    return {
        'id': order.pk,
        'product_id': order.product_id,
        'fee': order.fee,
        'total': order.total,
        'quantity': order.quantity,
        'status': order.status,
    }


@app.get('/orders')
def get_all():
    return [format(pk) for pk in Order.all_pks()]


# The artificial delay for order processing
def order_complete(order: Order):
    time.sleep(5)
    order.status = 'completed'
    order.save()
    redis.xadd(name='order-completed', fields=order.dict())
