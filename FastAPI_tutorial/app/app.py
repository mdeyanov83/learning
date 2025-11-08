from fastapi import FastAPI

app = FastAPI()

text_posts = {}

@app.get("/posts")
def get_all_posts():
    return text_posts
