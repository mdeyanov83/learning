#!/bin/bash

echo "Starting Uvicorn FastAPI server..."

# Running the command
uvicorn app.main:app --reload
