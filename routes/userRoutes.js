
const express = require('express');
const { loginUser, getProfile } = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');

const router = express.Router();

router.post('/login', loginUser);           // Public route for login
router.get('/profile', authMiddleware, getProfile);  // Protected route

module.exports = router;
