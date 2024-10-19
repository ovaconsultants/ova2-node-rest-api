
const express = require('express');
const { loginUser, getProfile, getRegistrationType , registerUser, FetchUsers, Search, AuthenticateAdminUser, updateUser, fetchRoles , fetchCompanyTypes , fetchCompanies ,postCompanyData} = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');
// const { pool } = require('mssql');

const router = express.Router();

router.post('/login', loginUser);           // Public route for login
router.get('/profile', authMiddleware, getProfile);  // Protected route
router.get('/registrationType',getRegistrationType);
router.post('/registerUser', registerUser);
router.get('/fetchUsers',FetchUsers);
router.get('/userSearch',Search);
router.post('/authenticateAdminUser', AuthenticateAdminUser)
router.put('/updateUser', updateUser)
router.get('/fetchRoles' , fetchRoles)
router.get('/fetchCompayTypes' , fetchCompanyTypes)
router.get('/fetchCompanies' , fetchCompanies)
router.post('/postCompanyData' , postCompanyData)
module.exports = router;
    