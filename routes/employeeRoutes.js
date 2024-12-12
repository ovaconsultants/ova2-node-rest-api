const express = require('express');
const { retrieve_employees , postingEmployeeSalaryData , fetchSalaryData  , fetchUserWithRegistrationId , fetchEmployeeSalaryYears} =   require('../controllers/employeeController')
const router = express.Router();


router.get('/retrieve_employees', retrieve_employees);
router.post('/postingEmployeeSalaryData',postingEmployeeSalaryData );
router.get('/fetchSalaryData/:registrationId/:year', fetchSalaryData );
router.get("/fetchEmployeeSalaryYears/:employeeId" , fetchEmployeeSalaryYears );
module.exports = router;    