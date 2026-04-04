import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app import schemas
from app.config import settings
from app.database import Base, get_db
from app.main import app

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

# create missing tables
Base.metadata.create_all(bind=engine)


def override_get_db():
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()


app.dependency_overrides[get_db] = override_get_db
# client = TestClient(app)

# FIXTURES

@pytest.fixture
def client():
    # run code before we run our test

    # drop all tables
    Base.metadata.drop_all(bind=engine)
    # create all tables
    Base.metadata.create_all(bind=engine)

    yield TestClient(app)

    # run code after we run the tests


# TESTS

# simplest scenario - test the root / route
def test_root(client):
    res = client.get('/')
    print(res.json().get('message'))
    assert res.status_code == 200
    assert res.json().get('message') == 'welcome to my api'


def test_user(client):
    res = client.post(
        '/users',
        json={
            'email': 'hello123@gmail.com',
            'password': 'password123',
        },
    )
    # this will perform validation that all required fields are present in the response
    new_user = schemas.UserOut(**res.json())
    assert new_user.email == 'hello123@gmail.com'
    assert res.status_code == 201
