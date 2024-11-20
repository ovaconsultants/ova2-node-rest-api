const p = require("../config/db"); 


// retreive all the employee from the database 
const retrieve_employees = async (req ,res)=> {
        try {
            const {rows} = await p.query('SELECT * FROM ova2.udf_retrieve_employee_list();');
            res.send(rows) ;
        } catch (error) {
           console.log("An error is occured while fetching employees") ;
           throw error ; 
        }

}


// posting salary data in database through json object 
const  postingEmployeeSalaryData  = async (req,res)=>{
       console.log(req) ;
       const { salaryData } = req.body ;
       console.log(salaryData) ;
    try {
        const {rows} = await p.query(' SELECT ova2.udf_update_employee_salary_details($1::jsonb)',[salaryData]) ;
        res.send(rows);
    } catch (error) {
        console.log("An error is occured while fetching employees") ;
        throw error ; 
    }
}

const fetchSalaryData = async (req, res) => {
  const { registrationId } = req.params;

  try {
    if (!registrationId || isNaN(parseInt(registrationId))) {
        return res.status(400).send({ error: "Invalid or missing registrationId" });
      }
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_pay_slip_data_by_registration_id($1::int);",
      [parseInt(registrationId)] 
    );
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while fetching employees:", error);
    res.status(500).send({ error: "Internal Server Error" });
  }
};



module.exports = {
    retrieve_employees,
    postingEmployeeSalaryData,
    fetchSalaryData
}