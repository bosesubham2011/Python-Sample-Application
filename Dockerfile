FROM ubuntu:latest

# Avoid interactive prompts during apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /app

# Install required dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment and install dependencies
COPY requirements.txt /app/
RUN python3 -m venv venv && \
    ./venv/bin/pip install --upgrade pip && \
    ./venv/bin/pip install -r requirements.txt

# Copy application code
COPY devops /app/devops

# Set virtual environment as default Python
ENV PATH="/app/venv/bin:$PATH"

# Set working directory
WORKDIR /app/devops

# Expose application port
EXPOSE 8000

# Entry point
ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]