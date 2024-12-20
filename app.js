const express = require('express');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes');
const cors = require('cors');
const cookieParser = require('cookie-parser'); 
const emailRoutes = require('./routes/emailRoutes');
const companyRoutes = require('./routes/companyRoutes') ;
const employeeRoutes = require('./routes/employeeRoutes');
const contactRoutes = require('./routes/contactRoutes');
const jobRoutes = require('./routes/jobRoutes')



dotenv.config();

const app = express();
app.use(cookieParser());
app.use(cors({
  origin: 'http://localhost:3000', // Allow frontend to access the backend
  credentials: true, // Allow cookies (including JWT cookie) to be sent
}));
app.use(express.json()); // Parse JSON bodies

// Register routes
app.use('/api/users', userRoutes);
app.use('/api', emailRoutes);
app.use('/api', contactRoutes)
app.use('/api/company',companyRoutes);
app.use('/api/employee', employeeRoutes)
app.use('/api/jobs', jobRoutes)



// Start server
const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
