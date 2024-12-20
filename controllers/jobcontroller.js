const p = require("../config/db"); 



const  postJobPostingJson = async (req, res) => {
   const jobData = req.body;
    try {
       console.log("Incoming Job Data:", jobData);
       const query = "SELECT ova2.udf_insert_job_posting_from_json($1);";
      const { rows } = await p.query(query, [jobData]);
      res.status(201).send({
        message: rows[0]?.udf_insert_job_posting_from_json || "Job posting inserted successfully."
      });
    } catch (error) {
      console.error("Error occurred:", error);
     res.status(500).send({
        message: "An error occurred while inserting the job posting.",
        error: error.message
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

 module.exports = { postJobPostingJson, retrieveJobPostings };