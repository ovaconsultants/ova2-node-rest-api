const p = require("../config/db");


const postExceptionLogs = async (req, res) => {
  const logData = req.body; // JSON object containing exception log details

  try {
    const query = `SELECT ova2.udf_insert_exception_log_from_json($1);`;
    const response = await p.query(query, [JSON.stringify(logData)]);
    res.status(201).send({ message: response.rows[0].udf_insert_exception_log_from_json });
  } catch (error) {
    console.error("Error inserting exception log:", error);
    res.status(500).send({
      message: "Internal server error",
      error: error.message,
    });
  }
};
  
const getExceptionLogs = async (req, res) => {
  const { severity, source } = req.query;

  try {
      const query = "SELECT * FROM ova2.udf_fetch_exception_logs($1, $2);";
      const { rows } = await p.query(query, [severity || null, source || null]);

      if (rows.length > 0) {
          // PostgreSQL JSONB result will be in rows[0].udf_fetch_exception_logs
          res.status(200).send(rows[0].udf_fetch_exception_logs);
      } else {
          res.status(404).send({ message: 'No logs found' });
      }
  } catch (error) {
      console.error('Error fetching exception logs:', error);
      res.status(500).send({ message: 'Internal server error', error: error.message });
  }
};



  module.exports = { postExceptionLogs, getExceptionLogs, };