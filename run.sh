#!/bin/bash

# Set the port (you can change this)
PORT=3011

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo "Installing requirements..."
pip install -r requirements.txt

# Run the FastAPI application
echo "Starting server on port $PORT..."
uvicorn app.main:app --host 0.0.0.0 --port $PORT --reload 