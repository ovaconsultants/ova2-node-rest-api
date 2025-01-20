const { Int } = require("mssql");
const p = require("../config/db");
const  { generateToken }= require('../utils/jwtUtils')

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


// getting registrstion types from database
const getRegistrationType = (req, res) => {
  var resp;
  p.query(
    "SELECT * FROM ova2.udf_fetch_registration_type();",
    (err, response) => {
      if (err) {
        console.error("Query error", err.stack);
      } else {
        resp = response.rows;
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
      res.send({ users: resp });
    }
  });
};

// Admin user authentication functionality from database


const AuthenticateAdminUser = async (req, res) => {
  const { userName, password } = req.body;
  // console.log(req.body);

  try {
    const { rows } = await p.query(
      `SELECT * FROM ova2.udf_authenticate_user($1, $2);`,
      [userName, password]
    );

    if (rows.length === 0) {
      return res.status(401).json({ message: "Authentication failed. User not found." });
    }

    const token = generateToken(rows[0]._registration_id);
     console.log("Token generated for this user:", token);

   
    //  const isProduction = process.env.NODE_ENV === 'production';
     res.cookie('authToken', token, {
       httpOnly: true,
       maxAge: 3600 * 8 * 1000,
       sameSite: 'Lax',
     });
     
 
    const user = rows[0];
    return res.status(200).json({ message: "Authentication successful", user });

  } catch (error) {
    console.error("Error authenticating user:", error);
    return res.status(500).json({ message: "Error authenticating user", error: error.message });
  }
};




// Updating user in the databse and handle put request from the ui
// Controller Function
const updateUser = async (req, res) => {
  const { id, userNewData } = req.body;
  console.log(id);
  console.log(userNewData)
  if (!id || !userNewData) {
    return res.status(400).json({ error: 'ID and userNewData are required' });
  }

  try { 
    // Combine ID with userNewData into a single JSON object
    const userData = { registration_id: parseInt(id), ...userNewData };
     
    // Assuming you are using a PostgreSQL client library like pg or knex
    const result = await p.query(`
      SELECT ova2.udf_update_user_data($1::jsonb)
    `, [userData]);

    res.status(200).json({ message: 'User updated successfully'});
  } catch (error) {
    console.error('Error updating user:', error);
    res.status(500).json({ error: 'Failed to update user' });
  }
};

// fetching all the user roles
const fetchRoles = async (req, res) => {
  try {
    const { rows } = await p.query("select * from  ova2.udf_fetch_roles() ;");
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

// fetch user with the id from databse
const fetchUserWithId = async (req, res) => {
  try {
    const { userId } = req.params;
    const { rows } = await p.query(
      "SELECT ova2.udf_fetch_user_with_id($1::integer);",
      [parseInt(userId)]
    );
    res.json(rows[0]?.udf_fetch_user_with_id);
  } catch (error) {
    console.error("An error occurred while fetching user as JSON", error);
    res.status(500).json({ message: "An error occurred" });
  }
};

// deleting user 
const deleteUser = async (req, res) => {
  const { registration_id } = req.body;
  try {
    const { rows } = await p.query("SELECT ova2.udf_delete_user($1);", [
      registration_id,
    ]);
    res.send(rows[0]?.udf_delete_user);
  } catch (error) {
    console.error("An error occurred while deleting user ", error);
    res.status(500).json({ message: "An error occurred" });
  }
};

// fetching users with filetring with registration type id 
const fetchUsersWithRegistrationId = async (req, res) => {
  const { registration_id } = req.query;
  try {
    const { rows } = await p.query("SELECT * FROM ova2.udf_retrieve_users_names_by_registration_type_id($1::int);", [ registration_id]);
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while deleting user ", error);
    res.status(500).json({ message: "An error occurred" });
  }
}; 

// fetching users with filetring with registration type id 
const registerEnrollment = async (req, res) => {
  const courseData = req.body;
  console.log("getting this course data in server" , courseData);
  try {
    const { rows } = await p.query("SELECT ova2.udf_enroll_student($1::jsonb)", [ courseData]);
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while enrolling a  user ", error);
    res.status(500).json({ message: "An error occurred" });
  }
}; 

// fetching all the Enrollments in the All courses  
const fetchAllEnrollments = async (req, res) => {
  try {
    const { rows } = await p.query("SELECT * FROM ova2.udf_fetch_all_course_enrollments();");
    console.log(rows);
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while enrolling a  user ", error);
    res.status(500).json({ message: "An error occurred" });
  }
}; 


module.exports = {
  loginUser,
  getProfile,
  getRegistrationType,
  registerUser,
  FetchUsers,
  AuthenticateAdminUser,
  updateUser,
  fetchRoles,
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyDataJson,
  updateCompanyData,
  getCompanyDetails,
  gettingCompanyInJson,
  fetchUserWithId,
  deleteUser,
  fetchUsersWithRegistrationId ,
  registerEnrollment ,
  fetchAllEnrollments
};
