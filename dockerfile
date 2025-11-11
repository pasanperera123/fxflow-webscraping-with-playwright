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

# Copy the current directory contents into the container at /app
COPY . ${LAMBDA_TASK_ROOT}

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Run main.py when the container launches
CMD ["main.lambda_handler"]

# docker build -t my-lambda-fxflow-u .
# docker run -p 80:80 scraper

