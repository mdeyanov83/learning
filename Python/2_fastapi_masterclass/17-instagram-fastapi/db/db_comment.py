from datetime import datetime

from db.models import DbComment
from routers.schemas import CommentBase
from sqlalchemy.orm import Session


# create a new comment
# should implement a check if request.username matches the current user
def create(db: Session, request: CommentBase):
    new_comment = DbComment(
        text=request.text,
        username=request.username,
        post_id=request.post_id,
        timestamp=datetime.now(),
    )
    db.add(new_comment)
    db.commit()
    db.refresh(new_comment)
    return new_comment


# retrieve all comments for a speciic post from the databse
def get_all(db: Session, post_id: int):
    return db.query(DbComment).filter(DbComment.post_id == post_id).all()
