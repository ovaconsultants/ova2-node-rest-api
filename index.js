const express = require('express');
//import sql from 'mssql';
const app = express();

// SQL Server connection configuration
// const sqlConfig = {
//   user: process.env.DB_USER,
//   password: process.env.DB_PASSWORD,
//   database: process.env.DB_DATABASE,
//   server: process.env.DB_SERVER,
//   options: {
//     encrypt: true, // Use this for Azure
//     trustServerCertificate: true // If using a local SQL Server
//   }
// };

// Connect to the SQL Server database
// async function connectToDatabase() {
//   try {
//     await sql.connect(sqlConfig);
//     console.log('Connected to SQL Server');
//   } catch (err) {
//     console.error('Database connection error: ', err);
//   }
// }
//connectToDatabase();

// Create a basic route
app.get('/home', (req, res) => {
  res.send('Node.js API is running, welcome ova2!');
});

// Start the server
//const port = process.env.PORT || 3001;
const port =  3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
