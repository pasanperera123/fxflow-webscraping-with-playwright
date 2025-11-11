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

FROM --platform=linux/amd64 python:3.11-slim-bookworm

# Set the working directory in the container
WORKDIR /var/task

# Copy code & requirements
COPY . .

# Install system dependencies for Chromium
RUN apt-get update && apt-get install -y \
    wget curl ca-certificates fonts-liberation \
    libnss3 libatk1.0-0 libcups2 libxcomposite1 libxdamage1 \
    libxrandr2 libx11-xcb1 libxss1 libxtst6 libgbm1 libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Install Playwright Chromium
RUN python -m playwright install chromium

# Lambda handler
CMD ["main.lambda_handler"]

# docker build -t my-lambda-fxflow-u .
# docker run -p 80:80 scraper

