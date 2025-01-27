const express = require("express");
const multer = require('multer');
const upload = multer({ dest: 'upload/' });
const {
  loginUser,
  getProfile,
  getRegistrationType,
  registerUser,
  FetchUsers,
  AuthenticateAdminUser,
  updateUser,
  updateUserTechnologies,
  fetchRoles,
  fetchUserWithId,
  deleteUser,
  fetchUsersWithRegistrationId , 
  registerEnrollment ,
  fetchAllEnrollments,
  fetchSoftwareTechnologies,
  fetchTechnologyIds,
  postExcelFile
} = require("../controllers/userController");

const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();

// Public Routes
router.post("/login", loginUser);
router.get("/registrationType", getRegistrationType);
router.post("/registerUser", registerUser);
router.post("/authenticateAdminUser", AuthenticateAdminUser);
router.get("/fetchAllEnrollments" ,fetchAllEnrollments )
router.post("/upload", upload.single('file'), postExcelFile);


// Protected Routes
//router.use(authMiddleware);

router.get("/profile", getProfile);
router.get("/fetchUsers", FetchUsers);
router.put("/updateUser", updateUser);
router.put("/updateUserTechnologies", updateUserTechnologies);
router.get("/fetchUserTechnologies/:_registration_id", fetchTechnologyIds);
router.get("/fetchRoles", fetchRoles);
router.get("/fetchUserWithId/:userId", fetchUserWithId);
router.get("/fetchUsersWithRegistrationId", fetchUsersWithRegistrationId);
router.delete("/deleteUser/:userId", deleteUser);
router.post("/registerEnrollment" ,registerEnrollment);
router.get("/fetchtechnologies" ,fetchSoftwareTechnologies);




module.exports = router;
