# import psycopg2
# from psycopg2.extras import RealDictCursor
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from .config import settings

SQLALCHEMY_DATABASE_URL = (
    f'postgresql+psycopg2://'
    f'{settings.database_username}:{settings.database_password}'
    f'@{settings.database_hostname}:{settings.database_port}/{settings.database_name}'
)


# The engine is what is responsible for the database connection
engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# all FastAPI models inherit from Base
Base = declarative_base()


# Dependency
# yieds a database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# # Establish database connection
# try:
#     conn = psycopg2.connect(
#         host=settings.database_hostname,
#         database=settings.database_name,
#         user=settings.database_username,
#         password=settings.database_password,
#         # returns each row as a dictionary (RealDictRow) with column names
#         # instead of a List[values] with no column names
#         cursor_factory=RealDictCursor,
#     )
#     cursor = conn.cursor()
#     print('Database connection was successfull')
# except psycopg2.Error as error:
#     print('Connecting to database failed')
#     print('Error: ', error)
#     exit()
