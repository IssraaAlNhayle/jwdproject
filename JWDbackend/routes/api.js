// Importing necessary libraries and initializing the Express router
const express = require('express');
const bcrypt = require('bcrypt');
const pool = require('../db'); // Import the database pool from db.js
const router = express.Router(); // Used to define routes in an Express application
const saltRounds = 10; //refer to the number of iterations that a hashing algorithm applies when generating a hash from a password along with a salt

router.get('/', (req, res) => {
    res.send('Hello from Express'); // Response message
});

// Basic test route to verify server is running
router.get('/test', (req, res) => {
    res.send('test route');
});

// Query to fetch all genres from the database
// Returns an array of genres in JSON format
router.get('/genres', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM genres'); // Fetch all genres
        res.json(result.rows); // Send as JSON response
    } catch (error) {
        console.error('Error fetching genres:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// Route to get books by genre
router.get('/books/:genreId', async (req, res) => {
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

// Handles user login by validating credentials and establishing a session
// Responds with success message or appropriate error
router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) { //check if either username or password are not provided
        return res.status(400).json({ message: 'Username and password are required' });
    }
    try {
        const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
        if (result.rows.length > 0) { //checks if the query returned any rows
            const user = result.rows[0];
            const isMatch = await bcrypt.compare(password, user.password); //compares the provided password with the hashed password stored in the database

            if (isMatch) {
                req.session.userId = user.id; //enabling session-based authentication for the authenticated user
                return res.status(200).json({ success: true, username: user.username });
            } else { //password doesn't match
                return res.status(401).json({ message: 'Username or password wrong' });
            }
        } else { //no user was found with the provided username
            return res.status(401).json({ message: 'User doesn\'t exist' });
        }
    } catch (err) {
        console.error('Error during login:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Logout route to destroy the session
router.post('/logout', (req, res) => {
    req.session.destroy((err) => { //called to terminate the session associated with the user
        if (err) {
            return res.status(500).json({ message: 'Logout failed' });
        }
        res.status(200).json({ message: 'Logged out successfully' });
    });
});

// Route for new users' registration
router.post('/register', async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }

    try {
        const userCheck = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
        if (userCheck.rows.length > 0) { //checks if a user with the provided username already exists
            return res.status(409).json({ message: 'Username already exists' });
        }
        const hashedPassword = await bcrypt.hash(password, saltRounds); //If the username is available, the password is hashed using bcrypt.hash()
        const result = await pool.query('INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id', [username, hashedPassword]);
        res.status(201).json({ message: 'User registered successfully', userId: result.rows[0].id });
    } catch (err) {
        console.error('Error during registration:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Adds a book to the user's reading list after checking for duplicates
// If the book is in the completed list, it is removed from there
router.post('/add-to-reading', async (req, res) => {
    const { bookId } = req.body;
    const userId = req.session.userId;

    try {
        // Check if the book is already in the reading list
        const checkReadingQuery = 'SELECT * FROM reading WHERE users_id = $1 AND book_id = $2';
        const checkReadingResult = await pool.query(checkReadingQuery, [userId, bookId]);

        if (checkReadingResult.rows.length > 0) {
            return res.status(400).json({ message: 'Book is already in the reading list' });
        }

        // Check if the book is in the completed list
        const checkCompletedQuery = 'SELECT * FROM completed WHERE users_id = $1 AND book_id = $2';
        const checkCompletedResult = await pool.query(checkCompletedQuery, [userId, bookId]);

        if (checkCompletedResult.rows.length > 0) {
            // If the book is in the completed list, delete it from there
            const deleteCompletedQuery = 'DELETE FROM completed WHERE users_id = $1 AND book_id = $2';
            await pool.query(deleteCompletedQuery, [userId, bookId]);
        }

        // Add the book to the reading list
        const insertReadingQuery = 'INSERT INTO reading (users_id, book_id) VALUES ($1, $2)';
        await pool.query(insertReadingQuery, [userId, bookId]);

        res.status(200).json({ message: 'Book moved to reading list successfully' });
    } catch (err) {
        console.error('Error adding to reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to get the books in the reading list
router.get('/reading-list', async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from the session

    try {
        const query = `
            SELECT books.id, books.title, books.author, books.image, books.bookpdf
            FROM reading
            JOIN books ON reading.book_id = books.id
            WHERE reading.users_id = $1
        `;
        const result = await pool.query(query, [userId]);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Error fetching reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to remove a book from the reading list
router.delete('/reading-list/:bookId', async (req, res) => {
    const { bookId } = req.params;  // Get the bookId from the request parameters
    const userId = req.session.userId;  // Get the logged-in user's ID from the session

    try {
        const deleteQuery = 'DELETE FROM reading WHERE users_id = $1 AND book_id = $2';
        const result = await pool.query(deleteQuery, [userId, bookId]);

        if (result.rowCount > 0) {
            res.status(200).json({ message: 'Book removed from reading list successfully' });
        } else {
            res.status(404).json({ message: 'Book not found in the reading list' });
        }
    } catch (err) {
        console.error('Error removing from reading list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to add a book to the completed list and remove it from the reading list
router.post('/add-to-completed', async (req, res) => {
    const { bookId } = req.body;
    const userId = req.session.userId;

    try {
        // Insert the book into the completed list
        const insertQuery = 'INSERT INTO completed (users_id, book_id) VALUES ($1, $2)';
        await pool.query(insertQuery, [userId, bookId]);

        // Remove the book from the reading list
        const deleteQuery = 'DELETE FROM reading WHERE users_id = $1 AND book_id = $2';
        await pool.query(deleteQuery, [userId, bookId]);

        res.status(200).json({ message: 'Book moved to completed list successfully' });
    } catch (err) {
        console.error('Error moving book to completed list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to get the books in the completed list
router.get('/completed-list', async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from the session

    try {
        const query = `
            SELECT books.id, books.title, books.author, books.image, books.bookpdf
            FROM completed
            JOIN books ON completed.book_id = books.id
            WHERE completed.users_id = $1
        `;
        const result = await pool.query(query, [userId]);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Error fetching completed list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Checks if the user is logged in based on session data
// Returns login status and username if logged in
router.get('/session-check', async (req, res) => {
    const userId = req.session.userId; // Get the userId from the session
    if (userId) {
        try {
            // Fetch username based on userId
            const result = await pool.query('SELECT username FROM users WHERE id = $1', [userId]);
            const username = result.rows.length > 0 ? result.rows[0].username : null;
            res.json({ loggedIn: true, username }); // Return logged-in status and username
        } catch (error) {
            console.error('Error fetching username:', error);
            res.status(500).json({ loggedIn: false, error: 'Internal server error' });
        }
    } else {
        res.json({ loggedIn: false }); // User is not logged in
    }
});

// Route to add books to favorites
router.post('/add-to-favorites', async (req, res) => {
    const { bookId } = req.body;
    const userId = req.session.userId;

    try {
        const checkQuery = 'SELECT * FROM favorites WHERE users_id = $1 AND book_id = $2';
        const checkResult = await pool.query(checkQuery, [userId, bookId]);

        if (checkResult.rows.length > 0) {
            return res.status(200).json({ message: 'Book is already in the favorites list' });
        }

        const insertQuery = 'INSERT INTO favorites (users_id, book_id) VALUES ($1, $2)';
        await pool.query(insertQuery, [userId, bookId]);
        res.status(200).json({ message: 'Book added to favorites list successfully' });
    } catch (err) {
        console.error('Error adding to favorites list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to remove a book from favorites
router.delete('/remove-from-favorites/:bookId', async (req, res) => {
    const { bookId } = req.params;
    const userId = req.session.userId;

    try {
        const deleteQuery = 'DELETE FROM favorites WHERE users_id = $1 AND book_id = $2';
        const result = await pool.query(deleteQuery, [userId, bookId]);

        if (result.rowCount > 0) {
            res.status(200).json({ message: 'Book removed from favorites successfully' });
        } else {
            res.status(404).json({ message: 'Book not found in the favorites list' });
        }
    } catch (err) {
        console.error('Error removing from favorites list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
// Route to get favorite books
router.get('/favorites-list', async (req, res) => {
    const userId = req.session.userId; // Get the logged-in user's ID from the session

    try {
        const query = `
            SELECT books.id, books.title, books.author, books.image, books.bookpdf
            FROM favorites
            JOIN books ON favorites.book_id = books.id
            WHERE favorites.users_id = $1
        `;
        const result = await pool.query(query, [userId]);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error('Error fetching favorites list:', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});
module.exports = router;
