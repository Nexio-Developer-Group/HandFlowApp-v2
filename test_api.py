import requests
import json

BASE_URL = "http://localhost:8000"

def test_signup():
    print("\n=== Testing Signup ===")
    response = requests.post(
        f"{BASE_URL}/auth/signup",
        json={"email": "test@example.com", "password": "password123"}
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    return response.status_code == 200

def test_login():
    print("\n=== Testing Login ===")
    response = requests.post(
        f"{BASE_URL}/auth/login",
        json={"email": "test@example.com", "password": "password123"}
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    if response.status_code == 200:
        return response.json()
    return None

def test_protected_route(token):
    print("\n=== Testing Protected Route ===")
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.get(f"{BASE_URL}/user/protected", headers=headers)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    return response.status_code == 200

def test_complete_onboarding(token):
    print("\n=== Testing Complete Onboarding ===")
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(f"{BASE_URL}/user/complete-onboarding", headers=headers)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    if response.status_code == 200:
        return response.json()["access_token"]
    return None

def test_refresh_token(refresh_token):
    print("\n=== Testing Refresh Token ===")
    response = requests.post(
        f"{BASE_URL}/auth/refresh",
        json={"refresh_token": refresh_token}
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
    return response.status_code == 200

def main():
    # Test signup
    if not test_signup():
        print("Signup failed!")
        return

    # Test login
    login_response = test_login()
    if not login_response:
        print("Login failed!")
        return

    access_token = login_response["access_token"]
    refresh_token = login_response["refresh_token"]

    # Test protected route
    if not test_protected_route(access_token):
        print("Protected route test failed!")
        return

    # Test complete onboarding
    new_access_token = test_complete_onboarding(access_token)
    if not new_access_token:
        print("Complete onboarding failed!")
        return

    # Test protected route with new token
    if not test_protected_route(new_access_token):
        print("Protected route test with new token failed!")
        return

    # Test refresh token
    if not test_refresh_token(refresh_token):
        print("Refresh token test failed!")
        return

    print("\n=== All tests completed successfully! ===")

if __name__ == "__main__":
    main() 