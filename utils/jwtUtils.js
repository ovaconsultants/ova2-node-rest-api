const jwt = require('jsonwebtoken');

// Generate JWT token
const generateToken = (userId) => {
  // mock secret key 
  process.env.JWT_SECRET = "Ova2^%$#" ;
    if (!process.env.JWT_SECRET) {
        throw new Error('JWT_SECRET is missing');
      }

  return jwt.sign({ id: userId }, process.env.JWT_SECRET, { expiresIn: '24h' });
};

// Verify JWT token
const verifyToken = (token) => {

  return jwt.verify(token, process.env.JWT_SECRET);
};

module.exports = { generateToken, verifyToken };
