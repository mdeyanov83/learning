from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# from . import models
# from .database import engine
from .routers import auth, post, user, vote

# # Generate all tables in the database
# no longer needed with Alembic
# models.Base.metadata.create_all(bind=engine)

app = FastAPI()

origins = [
    '*',
    # 'http://localhost:3000',
    # 'null'
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

# register routers
app.include_router(post.router)
app.include_router(user.router)
app.include_router(auth.router)
app.include_router(vote.router)


@app.get('/')
def root():
    return {'message': 'welcome to my api'}
