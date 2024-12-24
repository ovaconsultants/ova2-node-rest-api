const express = require("express");
const {  postJobPostingJson, retrieveJobPostings, deleteJobPosting,getJobPostingById  } = require("../controllers/jobcontroller");
const router = express.Router();

router.post("/job-posting", postJobPostingJson);
router.get("/retrieve-job-postings", retrieveJobPostings);
router.put('/delete-job-posting/:jobId', deleteJobPosting);
router.get('/job-posting/getById', getJobPostingById);
module.exports = router;

