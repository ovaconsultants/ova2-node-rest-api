const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  // Get the token from the cookies
  const token = req.cookies.authToken;  // assuming the token is stored in a cookie named "authToken"
  
  console.log("Received token:", token);  // Debugging: Log the token to see what is being received

  // Check if token exists
  if (!token) {
    return res.status(401).send({ message: 'No token provided.' });
  }

  try {
    // Verify the token using the secret key
    console.log("Verifying token with the secret key:", process.env.JWT_SECRET);
    
    // Decoding the token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    console.log("Decoded token information:", decoded);  // Log the decoded information

    // Attach the decoded user info to the request object for use in subsequent middleware/route handlers
    req.user = decoded;

    next(); // Proceed to the next middleware or route handler
  } catch (err) {
    // Log the error details to debug
    console.error("Error verifying the token:", err);

    // Handle specific error types (you can also adjust based on your needs)
    if (err.name === 'JsonWebTokenError') {
      return res.status(403).json({ message: 'Invalid token.', error: err.message });
    } else if (err.name === 'TokenExpiredError') {
      return res.status(403).json({ message: 'Token has expired.', error: err.message });
    } else {
      return res.status(403).json({ message: 'Invalid or expired token.', error: err.message });
    }
  }
};

module.exports = authMiddleware;




