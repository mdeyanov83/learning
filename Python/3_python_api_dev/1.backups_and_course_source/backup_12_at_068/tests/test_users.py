from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


# simplest scnearion - test the root / route
def test_root():
    response = client.get("/")
    print(response)
