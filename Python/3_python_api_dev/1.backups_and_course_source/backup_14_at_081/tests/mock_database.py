import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

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
