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

# Use prebuilt Playwright Python image with Chromium
FROM mcr.microsoft.com/playwright/python:1.40.0-focal

# Copy your Lambda code
COPY main.py ${LAMBDA_TASK_ROOT}/
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set Lambda handler
CMD ["main.lambda_handler"]

# docker build -t my-lambda-fxflow .
