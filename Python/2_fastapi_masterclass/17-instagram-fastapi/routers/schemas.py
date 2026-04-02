from datetime import datetime
from typing import List

from pydantic import BaseModel, ConfigDict


class UserBase(BaseModel):
    username: str
    email: str
    password: str


class UserDisplay(BaseModel):
    username: str
    email: str

    # class Config:
    #     orm_mode = True
    # This replaces 'class Config' and 'orm_mode'
    model_config = ConfigDict(from_attributes=True)


class PostBase(BaseModel):
    image_url: str
    # relative/absolute, depending on if image is uploaded to the API
    # or coming from the internet.
    image_url_type: str
    caption: str
    creator_id: int  # id of the user created that post


# For PostDisplay
class User(BaseModel):
    username: str

    # class Config:
    #     orm_mode = True
    # This replaces 'class Config' and 'orm_mode'
    model_config = ConfigDict(from_attributes=True)

# for PostDisplay
class Comment(BaseModel):
    text: str
    username: str
    timestamp: datetime
    model_config = ConfigDict(from_attributes=True)


class PostDisplay(BaseModel):
    id: int
    image_url: str
    image_url_type: str
    caption: str
    timestamp: datetime
    user: User
    comments: List[Comment]

    # class Config:
    #     orm_mode = True
    # This replaces 'class Config' and 'orm_mode'
    model_config = ConfigDict(from_attributes=True)


class UserAuth(BaseModel):
    id: int
    username: str
    email: str


class CommentBase(BaseModel):
    username: str
    text: str
    post_id: int
