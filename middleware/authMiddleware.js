const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  // Get the token from the cookies
  const token = req.cookies.authToken;  // assuming the token is stored in a cookie named "authToken"

  // Check if token exists
  if (!token) {
    return res.status(401).send({ message: 'No token provided.' });
  }

  try {
    // Verify the token using the secret key
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Attach the decoded user info to the request object for use in subsequent middleware/route handlers
    req.user = decoded;

    next(); // Proceed to the next middleware or route handler
  } catch (err) {
    // Handle errors, such as token expiration or invalid token
    return res.status(403).json({ message: 'Invalid or expired token.', error: err.message });
  }
};

module.exports = authMiddleware;


