from fastapi import APIRouter, HTTPException, status, Depends
from typing import Dict, Any
import jwt

from app.models.user import SignupRequest, LoginRequest, TokenResponse, RefreshTokenRequest
from app.core.security import create_access_token, create_refresh_token, verify_token
from app.services.user_service import create_user, get_user, update_onboarding_status
from app.core.config import JWT_SECRET_KEY, JWT_ALGORITHM

router = APIRouter()

@router.post("/signup", response_model=Dict[str, str])
async def signup(request: SignupRequest):
    create_user(request.email, request.password)
    return {
        "status": "success",
        "message": f"Account created for {request.email}"
    }

@router.post("/login", response_model=TokenResponse)
async def login(request: LoginRequest):
    user_data = get_user(request.email)
    if not user_data:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Email not found"
        )

    if user_data["password"] != request.password:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect password"
        )

    access_token = create_access_token(
        data={
            "sub": request.email,
            "onboarding_completed": user_data["onboarding_completed"]
        }
    )
    
    refresh_token = create_refresh_token(
        data={"sub": request.email}
    )

    return TokenResponse(
        access_token=access_token,
        refresh_token=refresh_token,
        expires_in=1800  # 30 minutes in seconds
    )

@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(request: RefreshTokenRequest):
    try:
        payload = jwt.decode(request.refresh_token, JWT_SECRET_KEY, algorithms=[JWT_ALGORITHM])
        
        if payload.get("type") != "refresh":
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Invalid token type"
            )
            
        user_data = get_user(payload["sub"])
        if not user_data:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found"
            )
            
        access_token = create_access_token(
            data={
                "sub": payload["sub"],
                "onboarding_completed": user_data["onboarding_completed"]
            }
        )
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=request.refresh_token,
            expires_in=1800
        )
    except jwt.ExpiredSignatureError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Refresh token has expired"
        )
    except jwt.JWTError:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid refresh token"
        ) 