import psycopg2
from fastapi import FastAPI
from psycopg2.extras import RealDictCursor

from . import models
from .database import engine
from .routers import auth, post, user

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# register routers
app.include_router(post.router)
app.include_router(user.router)
app.include_router(auth.router)


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


@app.get('/')
def root():
    return {'message': 'welcome to my api'}
