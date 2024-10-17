const { generateToken } = require("../utils/jwtUtils");
const { Pool } = require("pg");
const dbConfig = require("../config/dbConfig.js");
// Simulate user login
const loginUser = (req, res) => {
  const { username, password } = req.body;

  // Mock user validation (replace with real DB lookup)
  if (username === "test" && password === "password") {
    const token = generateToken(1); // Mock userId as 1
    return res.status(200).send({ token });
  }

  return res.status(401).send({ message: "Invalid credentials." });
};

// Protected route example
const getProfile = (req, res) => {
  res.send({ message: `Hello, user ${req.user.id}!` });
};

// connecting to database
const p = new Pool({
  user: dbConfig.user,
  host: dbConfig.host,
  database: dbConfig.database,
  password: dbConfig.password,
  port: dbConfig.port,
});

// getting registrstion types from database
const getRegistrationType = (req, res) => {
  var resp;
  p.query(
    "SELECT * FROM ova2.udf_fetch_registration_type();",
    (err, response) => {
      if (err) {
        console.error("Query error", err.stack);
      } else {
        console.log(response.rows);
        resp = response.rows;
        console.log(response);
      }
      res.send({ message: resp });
    }
  );
};

// registering the user in tbl_registration
const registerUser = async (req, res) => {
  try {
    await p.query(
      `
      SELECT ova2.udf_insert_into_registration(
        $1, $2, $3, $4, $5, $6, $7
      )
    `,
      Object.values(req.body)
    );

    res.status(200).json({ message: "User registered successfully!" });
  } catch (error) {
    console.error("Error registering user:", error);
    res
      .status(500)
      .json({ message: "Error registering user", error: error.message });
  }
};

// fetching all the users for the admin panel
const FetchUsers = async (req, res) => {
  let resp;
  p.query("SELECT * FROM ova2.udf_fetch_Users();", (err, response) => {
    if (err) {
      console.error("Query Error", err.stack);
    } else {
      resp = response.rows;
      console.log(resp);
      res.send({ users: resp });
    }
  });
};

// search functionality from the databse
const Search = async (req, res) => {
  const { query } = req.query; // Expect a query parameter called 'query'
  try {
    const { rows } = await p.query(
      `
      SELECT * FROM ova2.tbl_registration 
      WHERE first_name ILIKE $1 OR last_name ILIKE $1 OR email ILIKE $1`,
      [`%${query}%`]
    );

    res.status(200).json({ users: rows });
  } catch (error) {
    console.error("Error searching users:", error);
    res
      .status(500)
      .json({ message: "Error searching users", error: error.message });
  }
};

// Admin user authentication functionality from database
const AuthenticateAdminUser = async (req, res) => {
  console.log(req.body);
  const { userName, password } = req.body;
  try {
    const { rows } = await p.query(
      `SELECT * FROM ova2.udf_authenticate_user($1,$2);`,
      [userName, password]
    );
    console.log(rows);
    console.log("rows ens here");
    res.status(200).send({ user: rows[0] });
  } catch (error) {
    console.error("Error searching users:", error);
    res
      .status(500)
      .json({ message: "Error searching users", error: error.message });
  }
};

// Updating user in the databse and handle put request from the ui
const updateUser = async (req, res) => {
  const { id, userNewData } = req.body;
  console.log(id);
  console.log(userNewData);
  try {
    const query = `
    SELECT ova2.udf_update_user_data(
        $1::INT, 
        $2::VARCHAR, 
        $3::VARCHAR, 
        $4::VARCHAR, 
        $5::VARCHAR, 
        $6::VARCHAR, 
        $7::VARCHAR, 
        $8::INT, 
        $9::INT, 
        $10::BOOLEAN, 
        $11::BOOLEAN
    );
`;

    // Execute the query with the parameters
    await p.query(query, [
      id,
      userNewData.first_name || null,
      userNewData.last_name || null,
      userNewData.email || null,
      userNewData.phone || null,
      userNewData.password || null,
      userNewData.address || null,
      userNewData.role_id || null,
      userNewData.registration_type_id || null,
      userNewData.is_active || null,
      userNewData.is_deleted || null,
    ]);
    res.status(200).json({ message: "User updated successfully" });
  } catch (error) {
    console.error("Error updating user:", error);
    res
      .status(500)
      .json({ message: "Error updating user", error: error.message });
  }
};

// fetching all the user roles

const fetchRoles = async (req, res) => {
  try {
    const { rows } = await p.query("select * from  ova2.udf_fetch_roles() ;");
    console.log(rows);
    res.status(200).send(rows);
  } catch (error) {
    console.log("error ocuured during the fetching of Role Types");
    throw error;
  }
};

// fetching company Types
const fetchCompanyTypes = async (req, res) => {
  try {
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_company_types();"
    );
    console.log(rows);
    res.send(rows);
  } catch (error) {
    console.log("Erroe while fetching the company types");
    throw error;
  }
};

// fetching companies from database
const fetchCompanies = async (req, res) => {
  try {
    const { rows } = await p.query("SELECT * from ova2.fetch_companies();");
    console.log(rows);
    res.send(rows);
  } catch (error) {
    console.log("error ocurred fetching companies data from databse ");
    throw error;
  }
};

// posting company data to the databseng in databse "
const postCompanyData = async (req, res) => {
  // Log the request for debugging
  console.log(req);

  // Extract company data from the request body
  const companyData = req.body;

  try {
    const query = `
      SELECT ova2.udf_insert_company(
        $1::character varying,  
        $2::character varying, 
        $3::character varying,  
        $4::integer,            
        $5::character varying, 
        $6::text,            
        $7::integer,            
        $8::character varying,  
        $9::character varying,  
        $10::character varying,
        $11::character varying, 
        $12::character varying, 
        $13::text,             
        $14::jsonb              
      );
    `;

    // Ensure the required fields are provided or fallback to default values (where applicable)
    const values = [
      companyData.company_name || '',                    
      companyData.contact_no || '',                      
      companyData.email_address || '',                   
      companyData.company_type_id || 0,                  
      companyData.website_url || null,                   
      companyData.location || null,                      
      companyData.established_year || null,              
      companyData.industry_sector || null,               
      companyData.contact_person_name || '',             
      companyData.contact_person_designation || null,    
      companyData.contact_person_phone || '',            
      companyData.contact_person_email || '',            
      companyData.description || null,                   
      companyData.additional_info || null                
    ];

    // Execute the query
    const response = await p.query(query, values);

    // Send the successful response
    res.status(200).send(response); // Assuming you want to return the result of the function
  } catch (error) {
    // Log and handle the error
    console.error("Error occurred during the insertion of company data", error);

    // Send an error response to the client
    res.status(500).send("Error occurred while inserting company data");
  }
};

module.exports = {
  loginUser,
  getProfile,
  getRegistrationType,
  registerUser,
  FetchUsers,
  Search,
  AuthenticateAdminUser,
  updateUser,
  fetchRoles,
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyData,
};
