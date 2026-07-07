from flask import Flask, jsonify, render_template, request, redirect, url_for
import json
import os
import logging
from pymongo import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv

# Setup logging for debugging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# Load environment variables from .env file
load_dotenv()

uri = os.getenv("MONGO_URI")

# Create a new client and connect to the server with SSL bypass
client = MongoClient(uri, server_api=ServerApi('1'), tlsAllowInvalidCertificates=True)

db = client.DevOpsLearning
collection = db['TuteDude Assignment']

# Serve frontend `public` folder for static files and templates
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
# Construct absolute path: go up one level from backend/ to Docker Assignment/, then into frontend/public
FRONTEND_PUBLIC = os.path.realpath(os.path.join(BASE_DIR, '..', 'frontend', 'public'))
logger.info(f"Serving frontend from: {FRONTEND_PUBLIC}")
# Use backend's `templates/` folder for Jinja templates so Flask can render success.html
BACKEND_TEMPLATES = os.path.join(BASE_DIR, 'templates')
logger.info(f"Backend templates folder: {BACKEND_TEMPLATES}")
FRONTEND_URL = os.getenv("FRONTEND_URL")
app = Flask(__name__, static_folder=FRONTEND_PUBLIC, template_folder=BACKEND_TEMPLATES)

# @app.route('/')
# def index():
#     return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit_form():
    """Handle form submission and save to MongoDB"""
    try:
        # Get form data
        firstname = request.form.get('firstname')
        lastname = request.form.get('lastname')
        username = request.form.get('username')
        password = request.form.get('password')
        
        logger.info(f"Extracted: firstname={firstname}, lastname={lastname}, username={username}")
        
        # Validate form data
        if not all([firstname, lastname, username, password]):
            logger.warning("Missing required fields")
            return redirect(f"{FRONTEND_URL}/index.html", error="All fields are required")
        
        # Create document
        document = {
            'firstname': firstname,
            'lastname': lastname,
            'username': username,
            'password': password
        }
        
        # Insert into MongoDB
        result = collection.insert_one(document)
        logger.info(f"✓ Document inserted with ID: {result.inserted_id}")
        
        # Redirect to success page
        return redirect(f"{FRONTEND_URL}/success.html")
    
    except Exception as e:
        logger.error(f"Error during submission: {str(e)}", exc_info=True)
        return redirect('/index.html', error=f"Error: {str(e)}")

# @app.route('/success')
# def success():
#     """Display success message"""
#     return render_template('success.html')

if __name__ == '__main__':
    logger.info(f"Starting Flask app on port 5000")
    logger.info(f"Frontend folder: {FRONTEND_PUBLIC}")
    logger.info(f"MongoDB database: {db.name if client else 'NOT CONNECTED'}")
    app.run(debug=True, host='0.0.0.0', port=5000)