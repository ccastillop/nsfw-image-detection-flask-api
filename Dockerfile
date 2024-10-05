# First stage for installing dependencies
FROM python:3.9-slim AS builder

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN python -m venv /opt/venv && \
  . /opt/venv/bin/activate && \
  pip install --no-cache-dir -r requirements.txt

# Second stage for the application
FROM python:3.9-slim

# Set environment
ENV FLASK_ENV=production
WORKDIR /app

# Copy the installed dependencies from the first stage
COPY --from=builder /opt/venv /opt/venv

# Ensure the virtual environment is enabled
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY . .

# Expose the app port
EXPOSE 3030

# Run the application
CMD ["python", "app.py"]
