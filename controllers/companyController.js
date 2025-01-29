const p = require("../config/db");
const { Int } = require("mssql");
const XLSX = require('xlsx');

// fetching company Types
const fetchCompanyTypes = async (req, res) => {
  try {
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_company_types();"
    );
    res.send(rows);
  } catch (error) {
    console.log("Erroe while fetching the company types");
    throw error;
  }
};

// fetching companies from database
const fetchCompanies = async (req, res) => {
  try {
    const { rows } = await p.query("SELECT * from ova2.udf_fetch_companies();");
    res.send(rows);
  } catch (error) {
    console.log("error ocurred fetching companies data from databse ");
    throw error;
  }
};

// fetching Details of company with companyId
const getCompanyDetails = async (req, res) => {
  const { companyId } = req.params;
  try {
    const query = `SELECT * FROM ova2.udf_fetch_company_by_id($1);`;

    const { rows } = await p.query(query, [companyId]);

    if (rows.length) {
      res.status(200).json(rows[0]);
    } else {
      res.status(404).json({ message: "Company not found" });
    }
  } catch (error) {
    console.error("Error fetching company details:", error);
    res.status(500).json({
      message: "Error fetching company details",
      error: error.message,
    });
  }
};

// updating company data in databse
const updateCompanyData = async (req, res) => {
  const { companyId, companyData } = req.body;

  if (!companyId || !companyData) {
    return res
      .status(400)
      .json({ message: "Company ID and data are required." });
  }

  try {
    const { rows } = await p.query(
      `SELECT ova2.udf_update_company_from_json($1::INT, $2::JSONB);`,
      [companyId, JSON.stringify(companyData)]
    );
    const message = rows[0]?.udf_update_company_from_json;
    if (message) {
      const status = message === "Company updated successfully." ? 200 : 400;
      return res.status(status).json({ message });
    } else {
      return res
        .status(500)
        .json({ message: "Unexpected response from the database." });
    }
  } catch (error) {
    console.error("Error updating company:", error);
    return res
      .status(500)
      .json({ message: "Error updating company", error: error.message });
  }
};

//  posting company data
const postCompanyDataJson = async (req, res) => {
  companyData = req.body;
  const jsonObjectString = JSON.stringify(companyData);
  try {
    const query = "SELECT ova2.udf_insert_company_from_json($1);";
    const response = await p.query(query, [jsonObjectString]);
    res.send(response);
  } catch (error) {
    console.log("error ocuured");
    throw error;
  }
};

// getting company from the json as single object
const gettingCompanyInJson = async (req, res) => {
  console.log( req.params) ;
  try {
    const response = await p.query(
      "SELECT ova2.udf_fetch_company_by_id_in_json($1);",
      [companyId]
    );
    if (response.rows.length > 0) {
      const companyData = response.rows[0].udf_fetch_company_by_id_in_json;
      res.json(response);
    } else {
      res.status(404).json({ message: "Company not found" });
    }
  } catch (error) {
    console.error("An error occurred while fetching company as JSON", error);
    res.status(500).json({ message: "An error occurred" });
  }
};

// fetching company Types
const fetchCommunicationMediums = async (req, res) => {
  try { 
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_communication_mediums();"
    );
    res.send(rows);
  } catch (error) {
    console.log("Erroe while fetching the company types");
    throw error;
  }
};

// Server-side deleteCompany function (using POST)
const deleteCompany = async (req, res) => {
  const { companyId } = req.body; // Accepting companyId from the request body
  try {
    const { rows } = await p.query("SELECT ova2.udf_delete_company($1);", [parseInt(companyId)]);
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Error while deleting the company");
    res.status(500).json({ message: "An error occurred while deleting the company" });
  }
};

// fetching data of all assigned employees in HR Team 
const fetchAllEmployeeAllocations = async(req,res) => {
  try {
    const { rows } = await p.query(
      "SELECT * FROM ova2.get_all_employee_allocations();"
    );
    res.send(rows);
  } catch (error) {
    console.log("Erroe while fetching the company types");
    throw error;
  }
}

const addVendorComment = async (req, res) => {
  const { company_id, comment } = req.body;

  try {
    // Validate the input
    if (!company_id || !comment) {
      return res.status(400).json({ message: "Company ID and comment are required." });
    }

    // Define the query
    const query = `SELECT ova2.udf_add_vendor_comment($1::jsonb) AS result;`;

    // Prepare the JSON input
    const commentData = {
      company_id: company_id, // Using company_id here
      comment: comment,
    };

    // Execute the query
    const { rows } = await p.query(query, [JSON.stringify(commentData)]);

    // Return success response
    res.status(201).json({
      message: rows[0]?.result || "Comment added successfully",
    });
  } catch (error) {
    console.error("Error adding vendor comment:", error);
    res.status(500).json({
      message: "Error adding vendor comment",
      error: error.message,
    });
  }
};

const fetchCommentsByCompanyId = async (req, res) => {
  const { companyId } = req.params;

  if (!companyId) {
    return res.status(400).send({
      error: "Company ID is required.",
    });
  }

  try {
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_vendor_comments_by_company_id($1);",
      [companyId]
    );

    if (rows.length === 0) {
      return res.status(404).send({
        message: "No comments found for the given company ID.",
      });
    }

    res.status(200).send(rows);
  } catch (error) {
    console.error("Error occurred fetching vendor comments data from database: ", error);
    res.status(500).send({
      error: "Failed to fetch vendor comments data. Please try again later.",
    });
  }
};



const postExcelVendorFile = async (req, res) => {
  const { file } = req;

  if (!file) return res.status(400).send("No file uploaded.");

  try {
    // Read and parse the Excel file
    const workbook = XLSX.readFile(file.path);
    const sheetData = XLSX.utils.sheet_to_json(workbook.Sheets[workbook.SheetNames[0]]);
    console.log("Parsed sheet data:", sheetData);

    // Normalize field names to match expected format
    const normalizedData = sheetData.map((row) => ({
      companyName: row["Company Name"] || row["companyName"],
      mobileNo: row["Mobile Number"] || row["mobileNo"],
      EmailId: row["Email Address"] || row["EmailId"],
      location: row["Location"] || row["location"],
      currentPosition: row["Current Position"] || row["currentPosition"],
    }));

    // Prepare arrays to track successful and failed entries
    const successfulEntries = [];
    const failedEntries = [];

    for (const vendor of normalizedData) {
      try {
        console.log("Processing vendor:", vendor);

        const { companyName, mobileNo, EmailId, location, currentPosition } = vendor;

        // Validate required fields
        if (!companyName || !mobileNo || !EmailId || !location || !currentPosition) {
          const missingFields = [];
          if (!companyName) missingFields.push("companyName");
          if (!mobileNo) missingFields.push("mobileNo");
          if (!EmailId) missingFields.push("EmailId");
          if (!location) missingFields.push("location");
          if (!currentPosition) missingFields.push("currentPosition");
          throw new Error(`Missing required fields: ${missingFields.join(", ")}`);
        }

        // Construct the JSON object to pass to the stored procedure
        const companyData = {
          company_name: companyName,
          contact_no: mobileNo,
          email_address: EmailId,
          location,
          currentposition: currentPosition,
        };

        // Call the stored procedure
        const result = await p.query(
          `SELECT ova2.udf_insert_company_from_json($1) AS result;`,
          [JSON.stringify(companyData)]
        );

        // Parse the result
        const message = result.rows[0]?.result;

        // Track successful or failed insertion based on the result
        if (message === "Company inserted successfully.") {
          successfulEntries.push({ companyName, EmailId });
        } else {
          throw new Error(message);
        }

        
      } catch (error) {
        console.error(`Error processing vendor ${vendor.companyName || "Unknown"}:`, error);

        // Track failed entries with error details
        failedEntries.push({
          companyName: vendor.companyName || "Unknown",
          EmailId: vendor.EmailId || "Unknown",
          error: error.message,
        });

        continue; // Proceed to the next vendor
      }
    }

    // Return response with success and failure details
    res.status(200).json({
      message: "Processing completed.",
      successfulEntries,
      failedEntries,
    });
  } catch (error) {
    console.error("Error processing file:", error);
    res.status(500).json({ error: "Failed to process the Excel file." });
  }
};



module.exports = {
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyDataJson,
  updateCompanyData,
  getCompanyDetails,
  gettingCompanyInJson,
  fetchCommunicationMediums,
  deleteCompany,
  fetchAllEmployeeAllocations,
  addVendorComment,
  fetchCommentsByCompanyId,
  postExcelVendorFile
};
