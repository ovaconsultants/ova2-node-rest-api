const express = require('express');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes');
const cors = require('cors');


dotenv.config();

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// Register routes
app.use('/api/users', userRoutes);

// Start server

const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
