const express = require("express");
const {
  loginUser,
  getProfile,
  getRegistrationType,
  registerUser,
  FetchUsers,
  AuthenticateAdminUser,
  updateUser,
  fetchRoles,
  fetchUserWithId,
  deleteUser,
  fetchUsersWithRegistrationId
} = require("../controllers/userController");


const authMiddleware = require("../middleware/authMiddleware");
// const { pool } = require('mssql');

const router = express.Router();

router.post("/login", loginUser); // Public route for login
router.get("/profile", authMiddleware, getProfile); // Protected route
router.get("/registrationType", getRegistrationType);
router.post("/registerUser", registerUser);
router.get("/fetchUsers", FetchUsers);
router.post("/authenticateAdminUser", AuthenticateAdminUser);
router.put("/updateUser", updateUser);
router.get("/fetchRoles", fetchRoles);
router.get("/fetchUserWithId/:userId", fetchUserWithId);
router.get('/fetchUsersWithRegistrationId',fetchUsersWithRegistrationId)
router.post("/deleteUser", deleteUser);

module.exports = router;
