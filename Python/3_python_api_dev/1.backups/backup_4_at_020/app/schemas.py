from datetime import datetime

from pydantic import BaseModel


# Schema used for client data validation
class PostBase(BaseModel):
    title: str
    content: str
    published: bool = True


class PostCreate(PostBase):
    pass


class Post(PostBase):
    id: int
    created_at: datetime

    class Config:
        # orm_mode = True
        from_attributes = True
