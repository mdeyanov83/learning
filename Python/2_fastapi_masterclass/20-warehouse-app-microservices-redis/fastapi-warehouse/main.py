from fastapi import FastAPI
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
    host='redis-15506.c328.europe-west3-1.gce.cloud.redislabs.com', # redis cloud database
    port=15506, # redis cloud database host port
    password='', # database password
    decode_responses=True,
)


# Create an entry into the database
class Product(HashModel, index=True):
    name: str
    price: float
    quantity: int

    class Meta:
        database = redis


@app.post('/product')
def create(product: Product):
    return product.save()


@app.get('/product/{pk}')
def get(pk: str):
    return Product.get(pk)


@app.get('/products')
def all():
    # return Product.all_pks() # returns only the products' primary keys
    return [
        format(pk) for pk in Product.all_pks()
    ]  # build a list of each product based on the primary key (id)


def format(pk: str):
    product = Product.get(pk)
    return {
        'id': product.pk,
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
    }


@app.delete('/product/{pk}')
def delete(pk: str):
    return Product.delete(pk)
