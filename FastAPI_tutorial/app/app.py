from fastapi import FastAPI

app = FastAPI()

text_posts = {"1": {"title": "New Post", "content": "cool test post"}}

@app.get("/posts")
def get_all_posts():
    return text_posts
