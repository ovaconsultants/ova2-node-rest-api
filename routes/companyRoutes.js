const express = require("express");
const {
  fetchCompanyTypes,
  fetchCompanies,
  postCompanyDataJson,
  updateCompanyData,
  getCompanyDetails,
  gettingCompanyInJson,
}   = require( "../controllers/companyController") ;
const authMiddleware = require("../middleware/authMiddleware");
// const { pool } = require('mssql');

const router = express.Router();
router.get("/fetchCompayTypes", fetchCompanyTypes);
router.get("/fetchCompanies", fetchCompanies);
router.post("/postCompanyData", postCompanyDataJson);
router.get("/getCompanyDetails/:companyId", getCompanyDetails);
router.put("/updateCompanyData", updateCompanyData);
router.get("/gettingCompanyInJson/:companyId", gettingCompanyInJson);


module.exports = router;
