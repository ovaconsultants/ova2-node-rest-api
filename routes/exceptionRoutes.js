const express = require("express");
const {postExceptionLogs, getExceptionLogs   } = require("../controllers/exceptionLogsController");
const router = express.Router();

router.post("/insert-exception-logs", postExceptionLogs);
router.get("/get-exception-logs", getExceptionLogs);


module.exports = router;