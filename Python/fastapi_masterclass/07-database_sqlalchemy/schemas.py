from typing import List
from pydantic import BaseModel


# Article inside UserDisplay
class Article(BaseModel):
    title: str
    content: str
    published: bool
    class Config():
        orm_mode = True


# used for user creation request
class UserBase(BaseModel):
    username: str
    email: str
    password: str


class UserDisplay(BaseModel):
    username: str
    email: str
    items: List[Article] = []
    class Config():
        orm_mode = True


# User inside ArticleDisplay
class User(BaseModel):
    id: int
    username: str
    class Config():
        orm_mode = True


# used for article creation request
class ArticleBase(BaseModel):
    title: str
    content: str
    published: bool
    creator_id: int


class ArticleDisplay(BaseModel):
    title: str
    content: str
    published: bool
    user: User
    class Config():
        orm_mode = True



