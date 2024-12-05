const express = require("express");
const {  postContactQueryJson ,getAllQueries } = require("../controllers/contactController");
const router = express.Router();

router.post("/contact-query", postContactQueryJson);
router.get("/getAllQueries" ,getAllQueries)

module.exports = router;

