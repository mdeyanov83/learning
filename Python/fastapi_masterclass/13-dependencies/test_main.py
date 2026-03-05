from fastapi.testclient import TestClient
from main import app


client = TestClient(app)


def test_get_all_blogs():
    response = client.get("/blog/all")  # pass the endpoint path
    assert response.status_code == 200  # test assertion


def test_auth_error():
    # pass a non-existant user (or empty strings) to the login endpoint
    response = client.post(
        "/token",
        data={
            "username": "",
            "password": "",
        },
    )
    # assert that we did not receive an access token
    access_token = response.json().get("access_token")
    assert access_token is None
    # assert that we also got descriptive message
    message = response.json().get("detail")[0].get("msg")
    assert message == "Field required"


def test_auth_success():
    # pass a valid user to the login endpoint
    response = client.post(
        "/token",
        data={
            "username": "cat",
            "password": "cat",
        },
    )
    # assert that access_token exists (is not None)
    access_token = response.json().get("access_token")
    assert access_token


def test_post_article():
    # execute login endpoint
    auth = client.post(
        "/token",
        data={
            "username": "cat",
            "password": "cat",
        },
    )
    # retrieve the access token
    access_token = auth.json().get("access_token")
    # confirm access_token exists just as a precaution
    assert access_token

    # build our request, it is passed as json, instead of form data
    response = client.post(
        "/article/",
        json={
            "title": "Test article",
            "content": "Test content",
            "published": True,
            "creator_id": 1
        },
        headers = {
            "Authorization": "bearer " + access_token
        }
    )

    # make our assertions
    assert response.status_code == 200
    assert response.json().get("title") == "Test article"
