from flask import Flask, request, jsonify
from transformers import AutoModelForImageClassification, AutoImageProcessor
from PIL import Image
import torch

# Initialize the Flask app
app = Flask(__name__)

# Load the model and processor
model = AutoModelForImageClassification.from_pretrained("Falconsai/nsfw_image_detection")
processor = AutoImageProcessor.from_pretrained("Falconsai/nsfw_image_detection")

# Define a route for predictions
@app.route('/predict', methods=['POST'])
def predict():
    # Check if an image file is present in the request
    if 'image' not in request.files:
        return jsonify({"error": "No image file provided"}), 400

    # Get the image from the request
    image_file = request.files['image']
    image = Image.open(image_file)

    # Preprocess the image
    inputs = processor(images=image, return_tensors="pt")

    # Run inference
    outputs = model(**inputs)
    logits = outputs.logits

    # Get the predicted class
    predicted_class_idx = logits.argmax(-1).item()
    predicted_label = model.config.id2label[predicted_class_idx]

    # Return the prediction as JSON
    return jsonify({"predicted_label": predicted_label})

# Run the Flask app
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
