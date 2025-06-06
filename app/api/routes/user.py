from fastapi import APIRouter, Depends, status
from typing import Dict, Any

from app.core.security import verify_token
from app.services.user_service import update_onboarding_status
from app.core.security import create_access_token

router = APIRouter()

@router.post("/complete-onboarding")
async def complete_onboarding(payload: dict = Depends(verify_token)):
    user_email = payload["sub"]
    
    # Update onboarding status
    user_data = update_onboarding_status(user_email)
    
    # Create new access token with updated onboarding status
    access_token = create_access_token(
        data={
            "sub": user_email,
            "onboarding_completed": True
        }
    )
    
    return {
        "status": "success",
        "message": "Onboarding completed successfully",
        "access_token": access_token,
        "expires_in": 1800  # 30 minutes in seconds
    }

@router.get("/protected")
async def protected_route(payload: dict = Depends(verify_token)):
    return {
        "message": "This is a protected route",
        "user_email": payload["sub"],
        "onboarding_completed": payload.get("onboarding_completed", False)
    } 