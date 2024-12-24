const p = require("../config/db");

const postJobPostingJson = async (req, res) => {
  const jobData = req.body;
  try {
    console.log("Incoming Job Data:", jobData);
    const query = "SELECT ova2.udf_insert_job_posting_from_json($1);";
    const { rows } = await p.query(query, [jobData]);
    res.status(201).send({
      message:
        rows[0]?.udf_insert_job_posting_from_json ||
        "Job posting inserted successfully.",
    });
  } catch (error) {
    console.error("Error occurred:", error);
    res.status(500).send({
      message: "An error occurred while inserting the job posting.",
      error: error.message,
    });
  }
};

const retrieveJobPostings = async (req, res) => {
  try {
    const { country } = req.query;
    const query = `SELECT * FROM ova2.get_job_postings($1); `;
    const { rows } = await p.query(query, [country || null]);
    res.status(200).send({
      statusCode: 200,
      message: "Job Postings Retrieved Successfully.",
      data: rows,
    });
  } catch (error) {
    console.error("An error occurred while fetching job postings:", error);
    res.status(500).send({
      statusCode: 500,
      message: "An error occurred while fetching job postings.",
      error: error.message,
    });
  }
};

const deleteJobPosting = async (req, res) => {
  const { jobId } = req.params; 
  const { updatedBy } = req.body; 
  
  
  if (!jobId || jobId <= 0) {
    return res.status(400).json({
      statusCode: 400,
      message: "Valid Job ID is required.",
      data: "",
    });
  }
  
  if (!updatedBy) {
    return res.status(400).json({
      statusCode: 400,
      message: "'updatedBy' field is required.",
      data: "",
    });
  }
  
  try {
    const query = `SELECT ova2.udf_delete_job_posting($1, $2);`;
    const values = [jobId, updatedBy];
    
    const { rows } = await p.query(query, values);
    const wasDeleted = rows[0]?.udf_delete_job_posting;

    if (wasDeleted) {
      return res.status(200).json({
        statusCode: 200,
        message: "Job posting deleted successfully.",
        data: "",
      });
    } else {
      return res.status(404).json({
        statusCode: 404,
        message: "Job posting not found or not deleted.",
        data: "",
      });
    }
  } catch (error) {
    console.error("An error occurred while deleting the job posting:", error);
    return res.status(500).json({
      statusCode: 500,
      message: "An error occurred while deleting the job posting.",
      error: error.message,
    });
  }
};

const getJobPostingById = async (req, res) => {
  try {
    
    const { jobId } = req.query; 
   if (!jobId || isNaN(jobId) || jobId <= 0) {
      return res.status(400).send({
        statusCode: 400,
        message: "Valid Job ID is required.",
        data: "",
      });
    }

   const query = `SELECT * FROM ova2.udf_get_job_posting_by_id($1);`;
    const { rows } = await p.query(query, [jobId]);
  
    if (rows.length > 0) {
      return res.status(200).send({
        statusCode: 200,
        message: "Job posting retrieved successfully.",
        data: rows[0], 
      });
    } else {
      return res.status(404).send({
        statusCode: 404,
        message: "Job posting not found.",
        data: "",
      });
    }
  } catch (error) {
    console.error("An error occurred while fetching the job posting:", error);
    return res.status(500).send({
      statusCode: 500,
      message: "An error occurred while fetching the job posting.",
      error: error.message,
    });
  }
};



module.exports = { postJobPostingJson, retrieveJobPostings, deleteJobPosting,getJobPostingById };
