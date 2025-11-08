from fastapi import FastAPI, HTTPException
from app.schemas import PostCreate, PostResponse

app = FastAPI()

text_posts = {
    1: {"title": "New Post", "content": "Exploring the wonders of AI."},
    2: {"title": "Tech Update", "content": "Latest trends in machine learning."},
    3: {"title": "Daily Thoughts", "content": "A walk in the park clears the mind."},
    4: {"title": "Quick Tip", "content": "Use keyboard shortcuts to save time."},
    5: {"title": "Motivation", "content": "Keep pushing forward, no matter the obstacle."},
    6: {"title": "Foodie Corner", "content": "Tried a new recipe today—delicious!"},
    7: {"title": "Book Review", "content": "Just finished an amazing sci-fi novel."},
    8: {"title": "Travel Diary", "content": "Visited a hidden waterfall this weekend."},
    9: {"title": "Fitness Goals", "content": "Completed my first 5k run!"},
    10: {"title": "Random Thought", "content": "What if cats secretly rule the world?"}
}


@app.get("/posts")
def get_all_posts(limit: int = None):
    if limit:
        return list(text_posts.values())[:limit]
    return text_posts


@app.get("/posts/{id}")
def get_post(id: int):
    if id not in text_posts:
        raise HTTPException(status_code=404, detail="Post not found"
                            )
    return text_posts.get(id)


@app.post("/post")
def create_post(post: PostCreate) -> PostResponse:
    new_post = {"title": post.title, "content": post.content}
    text_posts[max(text_posts.keys()) + 1] = new_post
    return new_post


# @app.delete("/delete/{id}")
# def delete_post(id: int):
#     return text_posts.pop(id)
