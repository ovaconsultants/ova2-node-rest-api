const { generateToken } = require('../utils/jwtUtils');

// Simulate user login
const loginUser = (req, res) => {
  const { username, password } = req.body;

  // Mock user validation (replace with real DB lookup)
  if (username === 'test' && password === 'password') {
    const token = generateToken(1);  // Mock userId as 1
    return res.status(200).send({ token });
  }

  return res.status(401).send({ message: 'Invalid credentials.' });
};

// Protected route example
const getProfile = (req, res) => {
  res.send({ message: `Hello, user ${req.user.id}!` });
};

module.exports = { loginUser, getProfile };
