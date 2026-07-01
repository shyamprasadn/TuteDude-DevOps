// application to serve the frontend of the user input form

const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

// Route to serve the index.html file
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Runtime config endpoint: returns the backend URL (can be set with env BACKEND_URL)
app.get('/config', (req, res) => {
    const backendUrl = process.env.BACKEND_URL || 'http://localhost:5000';
    res.json({ backendUrl });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Frontend server is running on http://localhost:${PORT}`);
});

