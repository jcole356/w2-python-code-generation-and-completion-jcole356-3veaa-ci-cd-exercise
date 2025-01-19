# Use the official Python image from the Docker Hub
FROM python:3.14.0a1-slim AS base

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI application code into the container
COPY . .

# Set environment variables
ENV APP_ENV=prod \
  DB_HOST=localhost

# Expose the port that the FastAPI app runs on
EXPOSE 8080

# Command to run the FastAPI application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

# Healthcheck to ensure the container is running
HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1
