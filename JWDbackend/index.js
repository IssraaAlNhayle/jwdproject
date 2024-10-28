// index.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const session = require('express-session');
const crypto = require('crypto');
const apiRoutes = require('./routes/api'); // Import the routes from api.js
const pool = require('./db'); // Import the pool from db.js

const app = express();
const port = 3000;
const secretKey = crypto.randomBytes(64).toString('hex');

// Middleware setup
app.use(bodyParser.json());
app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true
}));
app.use(session({
    secret: secretKey,
    resave: false,
    saveUninitialized: false,
    cookie: { maxAge: 60 * 60 * 1000 },
    rolling: true
}));

// Test database connection
pool.connect((err, client, release) => {
    if (err) {
        return console.error('Error acquiring client', err.stack);
    }
    client.query('SELECT NOW()', (err, result) => {
        release();
        if (err) {
            return console.error('Error executing query', err.stack);
        }
        console.log('Database connected:', result.rows);
    });
});

// Use the API routes
app.use('/', apiRoutes); // Routes are mounted here

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
