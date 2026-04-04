from typing import List

import psycopg2
from fastapi import Depends, FastAPI, HTTPException, Response, status
from psycopg2.extras import RealDictCursor
from sqlalchemy.orm import Session

from . import models, schemas, utils
from .database import engine, get_db

models.Base.metadata.create_all(bind=engine)


app = FastAPI()


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


my_posts = [
    {'title': 'title of post 1', 'content': 'content of post 1', 'id': 1},
    {'title': 'favorite foods', 'content': 'I like pizza', 'id': 2},
]


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


# @app.get('/posts')
# def get_posts(db: Session = Depends(get_db)):
#     cursor.execute("""SELECT * FROM posts""")
#     posts = cursor.fetchall()  # Returns a list of each row
#     return {'data': posts}


@app.get('/posts', response_model=List[schemas.Post])
def get_posts(db: Session = Depends(get_db)):
    # This syntax is officially Legacy
    posts = db.query(models.Post).all()
    return posts


# @app.post('/posts', status_code=status.HTTP_201_CREATED)
# def create_posts(post: Post):
#     cursor.execute(
#         """INSERT INTO posts (title, content, published)
#             VALUES (%s, %s %s) RETURNING *""",
#         (post.title, post.content, post.published),
#     )
#     new_post = cursor.fetchone()  # retrieve the post from the database result set
#     conn.commit()  # commit changes to the database, making them persistent

#     return {'data': new_post}


@app.post('/posts', status_code=status.HTTP_201_CREATED, response_model=schemas.Post)
def create_posts(post: schemas.PostCreate, db: Session = Depends(get_db)):
    # new_post = models.Post(
    #     title=post.title,
    #     content=post.content,
    #     published=post.published,
    # )
    new_post = models.Post(**post.dict())
    db.add(new_post)
    db.commit()
    db.refresh(new_post)
    return new_post


# @app.get('/posts/{id}')
# def get_post(id: int):
#     cursor.execute(
#         """SELECT * FROM posts WHERE id = %s""",
#         (id,),  # expects a tuple of values
#     )
#     post = cursor.fetchone()
#     if not post:
#         raise HTTPException(
#             status_code=status.HTTP_404_NOT_FOUND,
#             detail=f'post with id: {id} was not found',
#         )
#     print(post)
#     return {'post_detail': post}


@app.get('/posts/{id}', response_model=schemas.Post)
def get_post(id: int, db: Session = Depends(get_db)):
    post = db.query(models.Post).filter(models.Post.id == id).first()
    if not post:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'post with id: {id} was not found',
        )
    return post


# @app.delete('/posts/{id}', status_code=status.HTTP_204_NO_CONTENT)
# def delete_post(id: int):
#     cursor.execute(
#         """DELETE FROM posts WHERE id = %s RETURNING *""",
#         (id,),
#     )
#     deleted_post = cursor.fetchone()
#     conn.commit()
#     if deleted_post is None:
#         raise HTTPException(
#             status_code=status.HTTP_404_NOT_FOUND,
#             detail=f'post with id: {id} does not exist',
#         )
#     # return is redundant in this case
#     return Response(status_code=status.HTTP_204_NO_CONTENT)


@app.delete('/posts/{id}', status_code=status.HTTP_204_NO_CONTENT)
def delete_post(id: int, db: Session = Depends(get_db)):
    post_query = db.query(models.Post).filter(models.Post.id == id)
    if post_query.first() is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'post with id: {id} does not exist',
        )
    post_query.delete(synchronize_session=False)
    db.commit()
    # return is redundant in this case
    return Response(status_code=status.HTTP_204_NO_CONTENT)


# @app.put('/posts/{id}')
# def update_post(id: int, post: Post):
#     cursor.execute(
#         """UPDATE posts SET title = %s, content = %s, published = %s
#             WHERE id = %s
#             RETURNING *""",
#         (post.title, post.content, post.published, id),
#     )
#     updated_post = cursor.fetchone()
#     conn.commit()
#     if updated_post is None:
#         raise HTTPException(
#             status_code=status.HTTP_404_NOT_FOUND,
#             detail=f'post with id: {id} does not exist',
#         )
#     return {'data': updated_post}


@app.put('/posts/{id}', response_model=schemas.Post)
def update_post(id: int, post: schemas.PostCreate, db: Session = Depends(get_db)):
    post_query = db.query(models.Post).filter(models.Post.id == id)
    updated_post = post_query.first()
    if updated_post is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'post with id: {id} does not exist',
        )
    post_query.update(post.dict(), synchronize_session=False)
    db.commit()
    db.refresh(updated_post)
    return updated_post


@app.post('/users', status_code=status.HTTP_201_CREATED, response_model=schemas.UserOut)
def create_user(user: schemas.UserCreate, db: Session = Depends(get_db)):

    # hash the password - user.password
    hashed_password = utils.hash(user.password)
    user.password = hashed_password

    new_user = models.User(**user.dict())
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user


@app.get('/users/{id}', response_model=schemas.UserOut)
def get_user(id: int, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == id).first()
    if user is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f'User with id: {id} does not exist',
        )
    return user
