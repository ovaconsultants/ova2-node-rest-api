const jwt = require('jsonwebtoken');

const authMiddleware = (req, res, next) => {
  const authHeader = req.header('Authorization');
  
  // Check if Authorization header exists
  if (!authHeader) {
    return res.status(401).send({ message: 'No token provided.' });
  }

  const token = authHeader.replace('Bearer ', '');

  try {

    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;  // Attach user info to request object
    next();  // Continue to the next middleware or route handler
  } catch (err) {
    console.log(err)
    return res.status(401).send({ message: 'Invalid token.' });
  }
};

module.exports = authMiddleware;
