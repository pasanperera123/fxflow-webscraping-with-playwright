# # Use AWS Lambda Python base image
# FROM public.ecr.aws/lambda/python:3.11
# 
# # Copy code into Lambda's default directory
# COPY . ${LAMBDA_TASK_ROOT}
# 
# # Install system dependencies required to build numpy/pandas
# RUN pip install -r requirements.txt
# 
# # Set the Lambda handler (module.function)
# CMD ["main.lambda_handler"]
# 
# # docker build -t my-lambda-fxflow .

# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set environment variables
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libdbus-1-3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libatspi2.0-0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libxcb1 \
    libxkbcommon0 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Install Playwright Chromium
RUN python -m playwright install chromium

# Install Playwright and its dependencies
RUN playwright install

# Run main.py when the container launches
CMD ["python3", "main.py"]

# docker build -t my-lambda-fxflow .
# docker run -p 80:80 scraper

