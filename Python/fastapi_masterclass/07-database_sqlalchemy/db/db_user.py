# from sqlalchemy.orm.session import Session
from sqlalchemy.orm import Session
from schemas import UserBase
from db.models import DbUser
from db.hash import Hash

def create_user(db: Session, request: UserBase):
    new_user = DbUser(
        username = request.username,
        email = request.email,
        password = Hash.bcrypt(request.password)
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user


def get_all_users(db: Session):
    return db.query(DbUser).all()



def get_user(db: Session, id: int):

    # should be properly handled if user with ID does not exist with raising an exception
    # from fastapi import HTTPException
    # user = db.query(DbUser).filter(DbUser.id == id).first()
    # if not user:
    #     raise HTTPException(status_code=404, detail='User not found')
    # return user

    return db.query(DbUser).filter(DbUser.id == id).first()


def update_user(db: Session, id: int, request: UserBase):
    user = db.query(DbUser).filter(DbUser.id == id)
    # handle any exceptions
    user.update({
        DbUser.username: request.username,
        DbUser.email: request.email,
        DbUser.password: Hash.bcrypt(request.password)
    })
    db.commit()
    return 'ok'


def delete_user(db: Session, id: int):
    user = db.query(DbUser).filter(DbUser.id == id).first()
    # handle any exceptions
    db.delete(user)
    db.commit()
    return 'ok'
