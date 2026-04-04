import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app import models
from app.config import settings
from app.database import Base, get_db
from app.main import app
from app.oauth2 import create_access_token

# SQLALCHEMY_DATABASE_URL = (
#     f'postgresql+psycopg2://'
#     f'{settings.database_username}:{settings.database_password}'
#     f'@{settings.database_hostname}:{settings.database_port}/{settings.database_name}'
# )
SQLALCHEMY_DATABASE_URL = (
    f'postgresql+psycopg2://'
    f'{settings.database_username}:{settings.database_password}'
    f'@{settings.database_hostname}:{settings.database_port}/fastapi_db_test'
)

engine = create_engine(SQLALCHEMY_DATABASE_URL)

TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


# This session fixture is going to yield the database object
@pytest.fixture()
def session():
    # drop all tables
    Base.metadata.drop_all(bind=engine)
    # create all tables
    Base.metadata.create_all(bind=engine)
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()


@pytest.fixture()
def client(session):
    # run code before we run our test

    # Do the override in the fixture
    def override_get_db():
        try:
            yield session
        finally:
            session.close()

    app.dependency_overrides[get_db] = override_get_db

    yield TestClient(app)

    # run code after we run the tests


@pytest.fixture
def test_user(client):
    user_data = {
        'email': 'john@gmail.com',
        'password': 'password123',
    }
    res = client.post('/users', json=user_data)

    # assert res.status_code == 201
    # print(res.json())

    new_user = res.json()
    new_user['password'] = user_data['password']
    return new_user


@pytest.fixture
def test_user2(client):
    user_data = {
        'email': 'eric@gmail.com',
        'password': 'password123',
    }
    res = client.post('/users', json=user_data)
    new_user = res.json()
    new_user['password'] = user_data['password']
    return new_user


@pytest.fixture
def token(test_user):
    return create_access_token({'user_id': test_user['id']})


@pytest.fixture
def authorized_client(client, token):
    client.headers = {**client.headers, 'Authorization': f'Bearer {token}'}
    return client


@pytest.fixture
def test_posts(test_user, session, test_user2):
    posts_data = [
        {
            'title': 'first title',
            'content': 'first content',
            'owner_id': test_user['id'],
        },
        {
            'title': 'second title',
            'content': 'second content',
            'owner_id': test_user['id'],
        },
        {
            'title': '3rd title',
            'content': '3rd content',
            'owner_id': test_user['id'],
        },
        {
            'title': '4th title',
            'content': '4th content',
            'owner_id': test_user2['id'],
        },
    ]

    # def create_post_model(post):
    #     return models.Post(**post)
    # post_map = map(create_post_model, posts_data)

    post_map = map(lambda post: models.Post(**post), posts_data)
    posts = list(post_map)
    session.add_all(posts)

    # manually hard-code the data in the database query - tedious and error prone
    # session.add_all(
    #     [
    #         models.Post(
    #             titel='first title',
    #             content='first_content',
    #             owner_id=test_user['id'],
    #         ),
    #         models.Post(
    #             titel='sedond title',
    #             content='second content',
    #             owner_id=test_user['id'],
    #         ),
    #         models.Post(
    #             titel='3rd title',
    #             content='3rd',
    #             owner_id=test_user['id'],
    #         ),
    #     ]
    # )

    session.commit()
    posts = session.query(models.Post).all()
    return posts
