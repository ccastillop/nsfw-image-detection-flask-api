# NSFW Image Detection Flask API

This repository contains a Flask API that serves the Falconsai NSFW Image Detection model from Hugging Face.
The API allows users to upload an image and get a classification of whether the image is "safe" or "nsfw."

The app is Dockerized for easy setup and deployment.

## Features

- Accepts image uploads via a POST request
- Returns a classification label ("safe" or "nsfw") using the Falconsai NSFW image detection model
- Simple and lightweight API built using Flask
- Easily deployable with Docker

## Getting Started

### Prerequisites

To run the app, you will need:

- **Docker** installed on your system. You can install Docker from [here](https://docs.docker.com/get-docker/).
- **Python 3.9** if you want to run the app locally without Docker (optional).

### Running the App with Docker

1. **Clone this repository**:

   ```bash
   git clone https://github.com/yourusername/nsfw-image-detection-flask-api.git
   cd nsfw-image-detection-flask-api
   ```

2. **Build the Docker image**:

   ```bash
   docker build -t nsfw-flask-app .
   ```

3. **Run the Docker container**:

   ```bash
   docker run -p 5000:5000 nsfw-flask-app
   ```

4. The app will be available at `http://localhost:5000`. You can now test the API using `curl` or Postman.

   **Example using `curl`**:

   ```bash
   curl -X POST -F 'image=@path_to_your_image.jpg' http://localhost:5000/predict
   ```

   The API will return a JSON response like:

   ```json
   {
     "predicted_label": "nsfw"
   }
   ```

### Running with Docker Compose (Optional)

If you prefer using Docker Compose for easier container management:

1. **Build and run the app**:

   ```bash
   docker-compose up --build
   ```

2. The app will be available at `http://localhost:5000`.

### Running the App Locally (Without Docker)

If you want to run the app locally without Docker:

1. **Install dependencies**:

   ```bash
   pip install -r requirements.txt
   ```

2. **Run the Flask app**:

   ```bash
   python app.py
   ```

3. The API will be available at `http://localhost:5000`.

### API Endpoints

- **POST /predict**: Upload an image and receive a prediction.

  **Request**:
  - `image` (required): The image file to be classified.

  **Response**:
  - `predicted_label`: The predicted class ("safe" or "nsfw").

### File Structure

```
.
├── app.py               # Flask API logic
├── Dockerfile           # Docker configuration
├── docker-compose.yml   # Docker Compose configuration (optional)
├── requirements.txt     # Python dependencies
└── README.md            # Project documentation
```

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

### Acknowledgments

- [Falconsai NSFW Image Detection Model](https://huggingface.co/Falconsai/nsfw_image_detection)
- Hugging Face `transformers` library
- Flask web framework
