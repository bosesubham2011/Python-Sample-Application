# Use an official Python runtime as a parent image
FROM python:3.11-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system dependencies.  Use --no-install-recommends to keep the image size small.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the application runs on
EXPOSE 7000

# Set environment variables.  These are often supplied at runtime.
#  It is better not to hardcode secrets inside the Dockerfile
ENV UBER_CLIENT_ID=""
ENV UBER_CLIENT_SECRET=""
#Set the redirect URI
ENV UBER_REDIRECT_URI="http://localhost:7000/submit"

# Define the command to run the application
CMD ["python", "app.py"]