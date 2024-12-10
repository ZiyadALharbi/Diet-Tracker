const express = require("express");
const { protect } = require("../middleware/auth_middleware.js");
const {
  addToDailyReport,
  getDailyReport,
  addMeal,
  editMeal,
  removeMeal,
  viewMeal,
  viewReports,
  viewReport,
} = require("../controllers/dailyReportController");

const router = express.Router();

router.get("/get-daily-reports", protect, getDailyReport);
router.post("/add-daily-reports", protect, addToDailyReport);
router.post("/add-meal", protect, addMeal);
router.put("/edit-meal", protect, editMeal);
router.delete("/remove-meal", protect, removeMeal);
router.get("/view-meal", protect, viewMeal);
router.get("/view-reports", protect, viewReports);
router.get("/view-report/:reportId", protect, viewReport);

module.exports = router;
