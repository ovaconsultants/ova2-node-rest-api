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
  const { registrationId, year } = req.params;

  try {
    // Validate the registrationId and year
    if (!registrationId || isNaN(parseInt(registrationId))) {
      return res.status(400).send({ error: "Invalid or missing registrationId" });
    }
    if (!year || isNaN(parseInt(year))) {
      return res.status(400).send({ error: "Invalid or missing year" });
    }

    // Fetch data from the database using both registrationId and year
    const { rows } = await p.query(
      "SELECT * FROM ova2.udf_fetch_pay_slip_month_data_by_registration_id_and_year($1::int, $2::int);",
      [parseInt(registrationId), parseInt(year)]
    );

    // Send the fetched data
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while fetching salary data:", error);
    res.status(500).send({ error: "Internal Server Error" });
  }
};

// fetching Employee years for salary 
const fetchEmployeeSalaryYears = async (req , res)=>{
  const { employeeId } = req.params;
  console.log(employeeId);
  try {
    const { rows } = await p.query("SELECT * FROM ova2.udf_get_employee_payslip_years($1::int);", [employeeId]);
    console.log(rows);
    res.send(rows);
  } catch (error) {
    console.error("An error occurred while deleting user ", error);
    res.status(500).json({ message: "An error occurred" });
  }
}




module.exports = {
    retrieve_employees,
    postingEmployeeSalaryData,
    fetchSalaryData , 
    fetchEmployeeSalaryYears
}