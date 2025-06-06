import requests
import json

BASE_URL = "http://localhost:3011"

def test_admin_login():
    print("\n=== Testing Admin Login ===")
    response = requests.post(
        f"{BASE_URL}/auth/login",
        json={"email": "admin@gmail.com", "password": "1524"}
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    return response.status_code == 200

if __name__ == "__main__":
    test_admin_login() 