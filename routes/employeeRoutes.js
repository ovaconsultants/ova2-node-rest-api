const express = require('express');
const { retrieve_employees , postingEmployeeSalaryData , fetchSalaryData  , fetchUserWithRegistrationId} =   require('../controllers/employeeController')
const router = express.Router();


router.get('/retrieve_employees', retrieve_employees);

router.post('/postingEmployeeSalaryData',postingEmployeeSalaryData );
router.get('/fetchSalaryData/:registrationId', fetchSalaryData )
module.exports = router;