// db.js
const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'jwddatabase',
    password: '18he@90tyO',
    port: 5432,
});

// Export the pool for use in other files
module.exports = pool;
