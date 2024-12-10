const express = require("express");
const { protect } = require("../middleware/auth_middleware.js");
const { addDailyGoals, editDailyGoals, viewDailyGoals } = require("../controllers/dailyGoalController.js");

const router = express.Router();

// Add Daily Goals
router.post("/add-daily-goals", protect, addDailyGoals);

// Edit Daily Goals
router.put("/edit-daily-goals", protect, editDailyGoals);

// View Daily Goals
router.get("/view-daily-goals", protect, viewDailyGoals);

module.exports = router;
