const jwt = require('jsonwebtoken');

// Generate JWT token
const generateToken = (userId) => {
  // eslint-disable-next-line no-undef
  return jwt.sign({ id: userId }, process.env.JWT_SECRET, { expiresIn: '1h' });
};

// Verify JWT token
const verifyToken = (token) => {
  // eslint-disable-next-line no-undef
  return jwt.verify(token, process.env.JWT_SECRET);
};

module.exports = { generateToken, verifyToken };
