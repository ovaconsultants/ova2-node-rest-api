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
  fetchUsersWithRegistrationId , 
  registerEnrollment ,
  fetchAllEnrollments
} = require("../controllers/userController");

const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();

// Public Routes
router.post("/login", loginUser);
router.get("/registrationType", getRegistrationType);
router.post("/registerUser", registerUser);
router.post("/authenticateAdminUser", AuthenticateAdminUser);
router.get("/fetchAllEnrollments" ,fetchAllEnrollments )


// Protected Routes
//router.use(authMiddleware);

router.get("/profile", getProfile);
router.get("/fetchUsers", FetchUsers);
router.put("/updateUser", updateUser);
router.get("/fetchRoles", fetchRoles);
router.get("/fetchUserWithId/:userId", fetchUserWithId);
router.get("/fetchUsersWithRegistrationId", fetchUsersWithRegistrationId);
router.delete("/deleteUser/:userId", deleteUser);
router.post("/registerEnrollment" ,registerEnrollment)



module.exports = router;
