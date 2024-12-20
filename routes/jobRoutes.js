const express = require("express");
const {  postJobPostingJson, retrieveJobPostings } = require("../controllers/jobcontroller");
const router = express.Router();

router.post("/job-posting", postJobPostingJson);
router.get("/retrieve-job-postings", retrieveJobPostings);



module.exports = router;

