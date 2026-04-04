from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URL = (
    'postgresql+psycopg2://fastapi_user:fastapi_password@localhost:5432/fastapi_db'
)

# The engine is what is responsible for the database connection
engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# all FastAPI modesl inherit from Base
Base = declarative_base()


# Dependency
# yieds a database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
