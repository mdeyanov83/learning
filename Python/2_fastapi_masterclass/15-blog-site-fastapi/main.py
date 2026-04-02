from database import models
from database.database import engine
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from routers import post

app = FastAPI()
app.include_router(post.router)

models.Base.metadata.create_all(engine)

# make /images statically available
app.mount("/images", StaticFiles(directory="images"), name="images")

# port 3000 will be used for our Web UI Client - React application
origins = [
    "http://localhost:3000"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
