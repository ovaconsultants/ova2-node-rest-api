const express = require('express');
const dotenv = require('dotenv').config({ path: '.env.development' });  // Load environment variables
const userRoutes = require('./routes/userRoutes');
const cors = require('cors');
const cookieParser = require('cookie-parser'); 
const emailRoutes = require('./routes/emailRoutes');
const companyRoutes = require('./routes/companyRoutes');
const employeeRoutes = require('./routes/employeeRoutes');
const contactRoutes = require('./routes/contactRoutes');
const jobRoutes = require('./routes/jobRoutes');
const jobApplicantRoutes = require('./routes/jobApplicantRoutes');

// Remove duplicate dotenv.config() call here, as it was already done in the previous line.

const app = express();
app.use(cookieParser());

app.use(cors({
  origin: process.env.WEB_URL, // Use the WEB_URL from environment or fallback to localhost
  methods: 'GET,POST',
  //credentials: true, // Allow cookies (including JWT cookie) to be sent
}));

app.use(express.json()); // Parse JSON bodies

// Register routes
app.use('/api/users', userRoutes);
app.use('/api', emailRoutes);
app.use('/api', contactRoutes);
app.use('/api/company', companyRoutes);
app.use('/api/employee', employeeRoutes);
app.use('/api/jobs', jobRoutes);
app.use('/api/applicant', jobApplicantRoutes);

// Start server
const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
