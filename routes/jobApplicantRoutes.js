const express = require("express");
const { postApplicantData, getApplicants } = require("../controllers/jobApplicantController")
const router = express.Router();

router.post("/job-applicant/create", postApplicantData);
router.get("/job-applicant/get", getApplicants);

module.exports = router;