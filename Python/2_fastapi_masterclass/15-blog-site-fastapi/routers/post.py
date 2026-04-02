import random
import shutil
import string

from database import db_post
from database.database import get_db
from fastapi import APIRouter, Depends, File, UploadFile
from routers.schemas import PostBase
from sqlalchemy.orm import Session

router = APIRouter(
    prefix="/post",
    tags=["post"],
)


@router.post("")
def create(request: PostBase, db: Session = Depends(get_db)):
    return db_post.create(db, request)


@router.get("/all")
def posts(db: Session = Depends(get_db)):
    return db_post.get_all(db)


@router.delete("/{id}")
def delete(id: int, db: Session = Depends(get_db)):
    return db_post.delete(id, db)


@router.post("/image")
def upload_image(image: UploadFile = File(...)):
    # generate a random string of letter to add to the name of the file
    letters = string.ascii_letters
    rand_str = "".join(random.choice(letters) for i in range(6))
    new = f"_{rand_str}."
    # build the filename and final path
    filename = new.join(image.filename.rsplit(".", 1))
    path = f"images/{filename}"

    # store the image file on the server
    with open(path, "w+b") as buffer:
        shutil.copyfileobj(image.file, buffer)

    return {"filename": path}
