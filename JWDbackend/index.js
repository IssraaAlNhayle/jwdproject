const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg');
const app = express();
const port = 3000; // You can change this port if needed
const bcrypt = require('bcrypt');
const saltRounds = 10;
const session = require('express-session');
const crypto = require('crypto');
app.use(bodyParser.json());
app.use(cors({
    origin: 'http://localhost:5173',
    credentials: true  // Allows cookies (credentials) to be sent/received
}));
// Generate a secure random secret key using the crypto module
const secretKey = crypto.randomBytes(64).toString('hex');
console.log('Generated Secret Key:', secretKey);
// PostgreSQL pool connection
const pool = new Pool({
    user: 'postgres', // Replace with your username
    host: 'localhost',
    database: 'jwddatabase', // Your database name
    password: '18he@90tyO', // Replace with your password
    port: 5432, // Default PostgreSQL port
});
// Session middleware
app.use(session({
    secret: secretKey,  // Use the generated secret key
    resave: false,              // Do not save the session if it's not modified
    saveUninitialized: false,   // Do not create session until something is stored
    cookie: { maxAge: 60 * 60 * 1000 },  // 1-hour session expiration
    rolling: true  // Session will be renewed on every request
}));
// Test the connection by running a simple query
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
// Define a route for the root path
app.get('/', (req, res) => {
    res.send('Hello from Express'); // Response message
});
// Define a route for testing
app.get('/test', (req, res) => {
    res.send('Test route is working');
});

// Define a route for genres
app.get('/genres', async (req, res)=> {
    try {
        const result = await pool.query('SELECT * FROM genres');
        res.json(result.rows);
    }
    catch (error){
        console.error('Error fetching genres:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});
// Define a route for books
app.get('/books/:genreId', async (req, res) => {
    const { genreId } = req.params;
    try {
        const booksQuery = 'SELECT * FROM books WHERE genre_id = $1';
        const result = await pool.query(booksQuery, [genreId]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error fetching books:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
});
//login route
app.post('/login', async (req, res) => {
    console.log('Login attempt received'); // Log when the login route is accessed

    const { username, password } = req.body;

    // Log the received request data
    console.log('Received username:', username);
    console.log('Received password:', password);

    if (!username || !password) {
        console.log('Missing username or password');
        return res.status(400).json({ message: 'Username and password are required' });
    }

    try {
        // Log query attempt
        console.log('Querying the database for user:', username);

        // Query the user by username
        const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);

        // Check if a user was found
        if (result.rows.length > 0) {
            console.log('User found:', result.rows[0]);
            const user = result.rows[0];

            // Compare the entered password with the stored hashed password
            const isMatch = await bcrypt.compare(password, user.password);

            if (isMatch) {
                req.session.userId = user.id; // Store user id in session
                console.log('Password match, login successful');
                return res.status(200).json({ message: 'Login successful' });
            } else {
                console.log('Password mismatch');
                return res.status(401).json({ message: 'Username or password wrong' });
            }
        } else {
            console.log('No user found with that username');
            return res.status(401).json({ message: 'Username or password wrong' });
        }
    } catch (err) {
        // Log any errors that occur during the process
        console.error('Error during login:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Logout route to destroy the session
app.post('/logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            return res.status(500).json({ message: 'Logout failed' });
        }
        res.status(200).json({ message: 'Logged out successfully' });
    });
});
//route for registration
app.post('/register', async (req, res) => {
    const { username, password } = req.body;

    // Check if the username and password are provided
    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }

    try {
        // Check if the username is already taken
        const userCheck = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
        if (userCheck.rows.length > 0) {
            return res.status(409).json({ message: 'Username already exists' });
        }

        // Hash the password before storing it
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Insert the new user into the database with the hashed password
        const result = await pool.query(
            'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id',
            [username, hashedPassword]  // Store the hashed password
        );

        // Return success message
        res.status(201).json({ message: 'User registered successfully', userId: result.rows[0].id });
    } catch (err) {
        console.error('Error during registration:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
app.get('/session-check', (req, res) => {
    if (req.session.userId) {
        res.json({ loggedIn: true });
    } else {
        res.json({ loggedIn: false });
    }
});
//route to get the books in the reading list
app.get('/reading-list', async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from the session
    try {
        // Query to retrieve the books from the reading list of the logged-in user
        const query = `
            SELECT books.id, books.title, books.author, books.image, books.bookpdf
            FROM reading
            JOIN books ON reading.book_id = books.id
            WHERE reading.users_id = $1
        `;
        const result = await pool.query(query, [userId]);

        // Return the list of books in the reading list
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Error fetching reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Route to remove a book from the reading list
app.delete('/reading-list/:bookId', async (req, res) => {
    const { bookId } = req.params;  // Get the bookId from the request parameters
    const userId = req.session.userId;  // Get the logged-in user's ID from the session

    try {
        // Delete the book from the reading list
        const deleteQuery = 'DELETE FROM reading WHERE users_id = $1 AND book_id = $2';
        const result = await pool.query(deleteQuery, [userId, bookId]);

        if (result.rowCount > 0) {
            // Book successfully removed from the reading list
            res.status(200).json({ message: 'Book removed from reading list successfully' });
        } else {
            // Book not found in the reading list
            res.status(404).json({ message: 'Book not found in the reading list' });
        }
    } catch (err) {
        console.error('Error removing from reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Route to add a book to the user's reading list
app.post('/add-to-reading', async (req, res) => {
    const { bookId } = req.body;
    const userId = req.session.userId;

    try {
        // Check if the book is in the 'completed' list
        const checkCompletedQuery = 'SELECT * FROM completed WHERE users_id = $1 AND book_id = $2';
        const checkCompletedResult = await pool.query(checkCompletedQuery, [userId, bookId]);

        if (checkCompletedResult.rows.length > 0) {
            // Remove the book from 'completed'
            const deleteCompletedQuery = 'DELETE FROM completed WHERE users_id = $1 AND book_id = $2';
            await pool.query(deleteCompletedQuery, [userId, bookId]);
            console.log('Book removed from completed list');
        }

        // Check if the book is already in the reading list
        const checkQuery = 'SELECT * FROM reading WHERE users_id = $1 AND book_id = $2';
        const checkResult = await pool.query(checkQuery, [userId, bookId]);

        if (checkResult.rows.length > 0) {
            return res.status(200).json({ message: 'Book already in the reading list' });
        }

        // Insert the book into the reading list
        const insertQuery = 'INSERT INTO reading (users_id, book_id) VALUES ($1, $2)';
        await pool.query(insertQuery, [userId, bookId]);

        res.status(200).json({ message: 'Book added to reading list successfully' });
    } catch (err) {
        console.error('Error adding to reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
app.post('/add-to-completed', async (req, res) => {
    const { bookId } = req.body;
    const userId = req.session.userId;

    try {
        // Insert the book into 'completed'
        const insertQuery = 'INSERT INTO completed (users_id, book_id) VALUES ($1, $2)';
        await pool.query(insertQuery, [userId, bookId]);

        // Remove the book from the reading list after it's completed
        const deleteQuery = 'DELETE FROM reading WHERE users_id = $1 AND book_id = $2';
        await pool.query(deleteQuery, [userId, bookId]);

        res.status(200).json({ message: 'Book added to completed list and removed from reading list' });
    } catch (err) {
        console.error('Error adding to completed list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
//route to get the books in the reading list
app.get('/completed-list', async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from the session
    try {
        // Query to retrieve the books from the reading list of the logged-in user
        const query = `
            SELECT books.id, books.title, books.author, books.image, books.bookpdf
            FROM completed
            JOIN books ON completed.book_id = books.id
            WHERE completed.users_id = $1
        `;
        const result = await pool.query(query, [userId]);

        // Return the list of books in the reading list
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Error fetching completed list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});


