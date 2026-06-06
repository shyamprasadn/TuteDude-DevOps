from flask import Flask, jsonify, render_template, request, redirect, url_for
import json
import os
from pymongo import MongoClient
from pymongo.server_api import ServerApi
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

uri = os.getenv("MONGO_URI")

# Create a new client and connect to the server with SSL bypass
client = MongoClient(uri, server_api=ServerApi('1'), tlsAllowInvalidCertificates=True)

db = client.DevOpsLearning
collection = db['TuteDude Assignment']

app = Flask(__name__)
app.json.sort_keys = False 

# Path to the data file
DATA_FILE = os.path.join(os.path.dirname(__file__), 'data.json')

@app.route('/')
def index():
    """Serve the index.html page"""
    return render_template('index.html')

@app.route('/submit', methods=['POST'])
def submit_form():
    """Handle form submission and save to MongoDB"""
    try:
        # Get form data
        firstname = request.form.get('firstname')
        lastname = request.form.get('lastname')
        username = request.form.get('username')
        password = request.form.get('password')
        
        # Validate form data
        if not all([firstname, lastname, username, password]):
            return render_template('index.html', error="All fields are required")
        
        # Create document
        document = {
            'firstname': firstname,
            'lastname': lastname,
            'username': username,
            'password': password
        }
        
        # Insert into MongoDB
        result = collection.insert_one(document)
        
        # Redirect to success page
        return redirect(url_for('success'))
    
    except Exception as e:
        # Return error message on same page
        return render_template('index.html', error=f"Error: {str(e)}")

@app.route('/success')
def success():
    """Display success message"""
    return render_template('success.html')

@app.route('/api', methods=['GET'])
def get_api_data():
    """Read data from the backend file and return as JSON"""
    try:
        with open(DATA_FILE, 'r') as file:
            data = json.load(file)
        return jsonify(data)
    except FileNotFoundError:
        return jsonify({"error": "Data file not found"}), 404
    except json.JSONDecodeError:
        return jsonify({"error": "Invalid JSON in data file"}), 500


@app.route('/submittodoitem', methods=['POST'])
def submittodoitem():
    """Accept itemName and itemDescription via POST and store in MongoDB."""
    try:

        item_name = request.form.get('itemName')
        item_description = request.form.get('itemDescription') 

        if not all([item_name, item_description]):
            return render_template('todo.html', error="All fields are required")
        document = {
            'itemName': item_name,
            'itemDescription': item_description
        }

        result = collection.insert_one(document)

        return redirect(url_for('success'))
    
    except Exception as e:
        return render_template('todo.html', error=f"Error: {str(e)}")

if __name__ == '__main__':
    app.run(debug=True)
