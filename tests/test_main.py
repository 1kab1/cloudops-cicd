from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_home():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["service"] == "cloudops-lab"


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_info():
    response = client.get("/info")
    assert response.status_code == 200
    assert response.json()["version"] == "0.1.0"
    assert "timestamp" in response.json()
