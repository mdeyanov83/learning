import psycopg2
from fastapi import FastAPI
from psycopg2.extras import RealDictCursor

from . import models
from .database import engine
from .routers import post, user

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# register routers
app.include_router(post.router)
app.include_router(user.router)


# Establish database connection
try:
    conn = psycopg2.connect(
        host='localhost',
        database='fastapi_db',
        user='fastapi_user',
        password='fastapi_password',
        # returns each row as a dictionary (RealDictRow) with column names
        # instead of a List[values] with no column names
        cursor_factory=RealDictCursor,
    )
    cursor = conn.cursor()
    print('Database connection was successfull')
except psycopg2.Error as error:
    print('Connecting to database failed')
    print('Error: ', error)
    exit()


# my_posts = [
#     {'title': 'title of post 1', 'content': 'content of post 1', 'id': 1},
#     {'title': 'favorite foods', 'content': 'I like pizza', 'id': 2},
# ]


# def find_post(id):
#     for p in my_posts:
#         if p['id'] == id:
#             return p


# def find_index_post(id):
#     for i, p in enumerate(my_posts):
#         if p['id'] == id:
#             return i


@app.get('/')
def root():
    return {'message': 'welcome to my api'}
