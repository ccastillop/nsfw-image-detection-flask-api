# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Set production environment
ENV FLASK_ENV=production

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt -f https://download.pytorch.org/whl/cpu

# Copy the current directory contents into the container at /app
COPY . /app

# Expose the port that the Flask app will run on
EXPOSE 3030

# Run app.py when the container launches
CMD ["python", "app.py"]


# # First stage for installing dependencies
# # FROM python:3.9-slim AS builder

# # Use a smaller base image (Alpine-based)
# FROM python:3.9-alpine
# # Set working directory
# WORKDIR /app

# # Copy requirements file and install dependencies
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# # RUN python -m venv /opt/venv && \
# #   . /opt/venv/bin/activate && \
# #   pip install --no-cache-dir -r requirements.txt

# # Second stage for the application
# FROM python:3.9-alpine

# # Set environment
# ENV FLASK_ENV=production
# WORKDIR /app

# # Copy the installed dependencies from the first stage
# COPY --from=builder /app /app

# # Ensure the virtual environment is enabled
# # ENV PATH="/opt/venv/bin:$PATH"

# # Copy application code
# COPY . /app

# # Expose the app port
# EXPOSE 3030

# # Run the application
# CMD ["python", "app.py"]
