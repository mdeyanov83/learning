from fastapi import FastAPI, Request, WebSocket
from router import blog_get, blog_post, user, article, product, file
from templates import templates
from auth import authentication
from db import models
from db.database import engine
from exceptions import StoryException
from fastapi.responses import JSONResponse, HTMLResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
import time
from client import html


app = FastAPI()
app.include_router(authentication.router)
app.include_router(file.router)
app.include_router(blog_get.router)
app.include_router(blog_post.router)
app.include_router(user.router)
app.include_router(article.router)
app.include_router(product.router)
app.include_router(templates.router)


@app.get("/hello")
def index():
    return {"message": "Hello World!"}


@app.exception_handler(StoryException)
def story_exception_handler(request: Request, exc: StoryException):
    return JSONResponse(
        status_code=418,
        content={"detail": exc.name},
    )

# WebSocket Chat HTML interface endpoint
@app.get("/")
async def get():
    return HTMLResponse(html)

clients = []

# Actual WebSocket chat endpoint
@app.websocket("/chat")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    clients.append(websocket)
    while True:
        data = await websocket.receive_text()
        for client in clients:
            await client.send_text(data)



# from fastapi import HTTPExceptio
# from fastapi.responses import PlainTextResponse
# @app.exception_handler(HTTPException)
# def custom_handler(request: Request, exc: HTTPException):
#     return PlainTextResponse(str(exc), status_code=400)


models.Base.metadata.create_all(engine)


@app.middleware("http")
async def add_middleware(request: Request, call_next):
    # at this point we have access to everything inside the request
    start_time = time.time()
    response = await call_next(request)
    duration = time.time() - start_time
    # now we can modify the reponse
    response.headers["duraton"] = str(duration)
    return response


origins = ["http://localhost:3000", "http://localhost:8000"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.mount(
    "/files",
    StaticFiles(directory="files"),
    name="files",
)
app.mount(
    "/templates/static",
    StaticFiles(directory="templates/static"),
    name="static",
)
