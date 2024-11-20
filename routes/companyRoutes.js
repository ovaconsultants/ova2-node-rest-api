const express = require("express");
const {
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyDataJson,
  updateCompanyData,
  getCompanyDetails,
  gettingCompanyInJson,
  fetchCommunicationMediums,
  deleteCompany,
  fetchAllEmployeeAllocations
}   = require( "../controllers/companyController") ;
const authMiddleware = require("../middleware/authMiddleware");
// const { pool } = require('mssql');

const  router = express.Router();
router.get("/fetchCompayTypes", fetchCompanyTypes);
router.get("/fetchCompanies", fetchCompanies);
router.post("/postCompanyData", postCompanyDataJson);
router.get("/getCompanyDetails/:companyId", getCompanyDetails);
router.put("/updateCompanyData", updateCompanyData);
router.get("/gettingCompanyInJson/:companyId", gettingCompanyInJson);
router.get("/fetchCommunicationMediums" , fetchCommunicationMediums);
router.post("/deleteCompany" , deleteCompany);
router.get("/fetchAllEmployeeAllocations",fetchAllEmployeeAllocations)


module.exports = router;
