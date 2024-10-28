const p = require("../config/db");

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
  const { companyId } = req.params;
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

module.exports = {
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyDataJson,
  updateCompanyData,
  getCompanyDetails,
  gettingCompanyInJson,
};
