const express = require('express');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes');
const cors = require('cors');
const emailRoutes = require('./routes/emailRoutes');
const companyRoutes = require('./routes/companyRoutes') ;
const employeeRoutes = require('./routes/employeeRoutes');
const contactRoutes = require('./routes/contactRoutes');
const jobRoutes = require('./routes/jobRoutes');
const jobApplicantRoutes = require('./routes/jobApplicantRoutes')




dotenv.config();

const app = express();
app.use(cors());
app.use(express.json()); // Parse JSON bodies

// Register routes
app.use('/api/users', userRoutes);
app.use('/api', emailRoutes);
app.use('/api/company',companyRoutes);
app.use('/api/employee', employeeRoutes);
app.use('/api', contactRoutes);
app.use('/api/jobs', jobRoutes);
app.use('/api/applicant', jobApplicantRoutes);



// Start server
const port = process.env.PORT || 3001;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
