# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies, Rust toolchain, and build essentials for ARM64
RUN apt-get update && apt-get install -y \
  gcc \
  libssl-dev \
  libffi-dev \
  curl \
  build-essential \
  pkg-config \
  && curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && . "$HOME/.cargo/env" \
  && rustup target add aarch64-unknown-linux-gnu

# Set up Rust environment explicitly for ARM64
ENV CARGO_BUILD_TARGET=aarch64-unknown-linux-gnu
ENV RUSTUP_HOME=/root/.rustup
ENV CARGO_HOME=/root/.cargo
ENV PATH=/root/.cargo/bin:$PATH

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that the Flask app will run on
EXPOSE 5000

# Run app.py when the container launches
CMD ["python", "app.py"]