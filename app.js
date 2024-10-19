const express = require('express');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes');
const cors = require('cors');
const emailRoutes = require('./routes/emailRoutes');


dotenv.config();

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// Register routes
app.use('/api/users', userRoutes);
app.use('/api', emailRoutes);

// Start server

const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
