const p = require("../config/db");


const postApplicantData = async (req, res) => {
    const applicantData = req.body;
  
    try {
      console.log("Incoming Applicant Data:", applicantData);
     if (applicantData.name) {
        const [firstName, ...lastNameParts] = applicantData.name.split(' ');
        applicantData.firstName = firstName || null;
        applicantData.lastName = lastNameParts.join(' ') || null;
      }
     if (applicantData.phone) {
        applicantData.phoneNumber = applicantData.phone;
      }
      const query = "SELECT ova2.udf_insert_job_seeker_from_json($1);";
      const { rows } = await p.query(query, [applicantData]);
  
      res.status(201).send({
        message:
          rows[0]?.udf_insert_job_seeker_from_json ||
          "Applicant inserted successfully.",
      });
    } catch (error) {
      console.error("Error occurred:", error);
      res.status(500).send({
        message: "An error occurred while inserting the applicant data.",
        error: error.message,
      });
    }
  };

  const getApplicants = async (req, res) => {
    try {
      const query = `SELECT * FROM ova2."udf_fetch_job_seeker"();`;
      const { rows } = await p.query(query);
     if (rows.length > 0) {
        const applicants = rows.map((applicant) => {
        const name = `${applicant.first_name || ''} ${applicant.last_name || ''}`.trim();
         return { ...applicant, name };
        });
     return res.status(200).send({
          statusCode: 200,
          message: "Applicants retrieved successfully.",
          data: applicants, 
        });
      } else {
       return res.status(404).send({
          statusCode: 404,
          message: "No applicants found.",
          data: [],
        });
      }
    } catch (error) {
      console.error("An error occurred while fetching the applicants:", error);
      return res.status(500).send({
        statusCode: 500,
        message: "An error occurred while fetching the applicants.",
        error: error.message,
      });
    }
  };
  
  
  
  
  module.exports = { postApplicantData, getApplicants };
