const p = require("../config/db");



const postContactQueryJson = async (req, res) => {
  const query_data = req.body;
  console.log("Incoming Query Data:", query_data); // Debug

  try {
    const query = "SELECT ova2.udf_insert_contact_query_from_json($1);";
    const {rows} = await p.query(query, [query_data]); 
    
    res.send(rows[0]?.udf_insert_contact_query_from_json);
  } catch (error) {
    console.error("Error occurred:", error); 
    res.status(500).send("An error occurred while processing the query.");
  }
};

const getAllQueries = async (req, res) => {
  try {
    const { rows } = await p.query("SELECT * FROM ova2.udf_get_all_contact_queries();");
    res.json(rows);
  } catch (error) {
    console.error("Error:", error);
    res.status(500).send("An error occurred.");
  }
};


module.exports = { postContactQueryJson , getAllQueries};