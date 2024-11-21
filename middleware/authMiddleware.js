const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  // Get the Authorization header
  const authHeader = req.headers['authorization'] || req.get('authorization');

  // Check if Authorization header exists
  if (!authHeader) {
    return res.status(401).send({ message: 'No token provided.' });
  }

  // Ensure header starts with "Bearer "
  if (!authHeader.startsWith('Bearer ')) {
    return res.status(401).send({ message: 'Invalid authorization header format.' });
  }

  const token = authHeader.replace('Bearer ', '');

  try {
    // Verify token and attach decoded user to request
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next(); // Proceed to the next middleware or route handler
  } catch (err) {
    // Handle token verification errors
    return res.status(403).json({ message: 'Invalid or expired token.', error: err.message });
  }
};

module.exports = authMiddleware;
