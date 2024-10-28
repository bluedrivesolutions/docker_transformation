# Use an official Python runtime as the base image
FROM python:3.11.9-alpine3.18

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Install Poetry for dependency management
RUN pip install poetry

# Install poetry depenendencies
RUN poetry install

# Copy the dbt project files into the container
COPY . .

# Set the entrypoint
ENTRYPOINT ["poetry"]