# FastAPI Tutorial

Learn Fast API With This ONE Project
https://www.youtube.com/watch?v=SR5NYCdzKkc


### To run:
Backend:
* uv run main.py

Frontend(StreamLit):
* uv  run streamlit run frontend.py


## Environment Setup

### Install UV (package + project manager):
* pip install uv

### Install dependencies:
* uv add package_name

    - fastapi[text](../../.vscode)
    - python-dotenv -> manage and load environment variables
    - fastapi-users[sqlalchemy] -> for handling authentication and authorization
    - imagekitio -> handle images and videos
    - uvicorn[standard] -> Web server in python, to serve the fastAPI application
    - aiosqlite -> database interaction
    - streamlit

### Create environment file
* .env

Used to store sensitive credentials.

Setup credentials for ImageKit (IMAGEKIT_PRIVATE_KEY, IMAGEKIT_PUBLIC_KEY, IMAGEKIT_URL)

### Project scaffolding
* /app   -> application source code
* /app/app.py

### FastAPI - default endpoints
* /docs  -> a page that specifies all of the endpoints and the configurations setup for our API. You can test endpoints from here
* /redoc  -> newer version of /docs

