import pytest
from jose import jwt

from app import schemas
from app.config import settings

# # simplest scenario - test the root / route
# def test_root(client):
#     res = client.get('/')
#     print(res.json().get('message'))
#     assert res.status_code == 200
#     assert res.json().get('message') == 'welcome to my api'


def test_create_user(client):
    res = client.post(
        '/users',
        json={
            'email': 'hello123@gmail.com',
            'password': 'password123',
        },
    )
    # this will perform validation that all required fields are present in the response
    new_user = schemas.UserOut(**res.json())
    assert new_user.email == 'hello123@gmail.com'
    assert res.status_code == 201


def test_login_user(client, test_user):
    res = client.post(
        '/login',
        data={
            'username': test_user['email'],
            'password': test_user['password'],
        },
    )
    # use the pydantic model to validate the response data format
    login_res = schemas.Token(**res.json())
    # validate and decode token
    payload = jwt.decode(
        login_res.access_token,
        settings.secret_key,
        algorithms=[settings.algorithm],
    )
    id = payload.get('user_id')

    assert id == test_user['id']
    assert login_res.token_type == 'bearer'
    assert res.status_code == 200


@pytest.mark.parametrize(
    'email, password, status_code',
    [
        ('wrongemail@gmail.com', 'password123', 401),
        ('john@gmail.com', 'wrongpassword', 401),
        ('wrongemail@gmail.com', 'wrongpassword', 401),
        (None, 'password123', 422),
        ('john@gmail.com', None, 422),
    ],
)
def test_incorrect_login(
    client,
    test_user,
    email,
    password,
    status_code,
):
    res = client.post(
        '/login',
        data={
            'username': email,
            'password': password,
        },
    )
    assert res.status_code == status_code
    # assert res.json().get('detail') == 'Invalid Credentials'
