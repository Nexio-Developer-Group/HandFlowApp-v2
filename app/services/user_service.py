import json
import os
from fastapi import HTTPException, status

from app.core.config import USER_FILE

def load_users():
    if not os.path.exists(USER_FILE):
        return {}
    with open(USER_FILE, "r") as f:
        return json.load(f)

def save_users(users):
    # Ensure the data directory exists
    os.makedirs(os.path.dirname(USER_FILE), exist_ok=True)
    with open(USER_FILE, "w") as f:
        json.dump(users, f, indent=4)

def get_user(email: str):
    users = load_users()
    return users.get(email)

def create_user(email: str, password: str):
    users = load_users()
    if email in users:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    users[email] = {
        "password": password,
        "onboarding_completed": False
    }
    save_users(users)
    return users[email]

def update_onboarding_status(email: str, completed: bool = True):
    users = load_users()
    if email not in users:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    users[email]["onboarding_completed"] = completed
    save_users(users)
    return users[email] 