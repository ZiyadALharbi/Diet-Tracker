const DailyReport = require("../models/daily_report.js");



// Add to Daily Report
exports.addToDailyReport = async (req, res) => {
  try {
    const { date, waterLiters, calories, fats, proteins, carbs, totalGrams, meals } = req.body;

    // Check if a report for this user and date already exists
    const report = await DailyReport.findOne({ user: req.user.id, date });

    if (report) {
      // Update the existing report
      const updatedReport = await DailyReport.findOneAndUpdate(
        { user: req.user.id, date },
        {
          $set: {
            ...(waterLiters !== undefined && { waterLiters }),
            ...(calories !== undefined && { calories }),
            ...(fats !== undefined && { fats }),
            ...(proteins !== undefined && { proteins }),
            ...(carbs !== undefined && { carbs }),
            ...(totalGrams !== undefined && { totalGrams }),
          },
          ...(meals && { $push: { meals: { $each: meals } } }),
        },
        { new: true, upsert: true } // Create if not exists
      );

      return res.status(200).json({ message: "Daily report updated successfully", report: updatedReport });
    }

    // Create a new report if none exists
    const newReport = await DailyReport.create({
      user: req.user.id,
      date,
      ...(waterLiters !== undefined && { waterLiters }),
      ...(calories !== undefined && { calories }),
      ...(fats !== undefined && { fats }),
      ...(proteins !== undefined && { proteins }),
      ...(carbs !== undefined && { carbs }),
      ...(totalGrams !== undefined && { totalGrams }),
      ...(meals && { meals }),
    });

    res.status(201).json({ message: "Daily report created successfully", report: newReport });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get daily report by date
exports.getDailyReport = async (req, res) => {
  try {
    const { date } = req.query;
    const report = await DailyReport.findOne({ user: req.user.id, date });
    if (!report)
      return res.status(404).json({ message: "Daily report not found" });
    res.json(report);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Add a meal
exports.addMeal = async (req, res) => {
  try {
    const { date, meal } = req.body;

    const report = await DailyReport.findOneAndUpdate(
      { user: req.user.id, date },
      { $push: { meals: meal } },
      { new: true, upsert: true } // Create report if it doesn't exist
    );
    res.json(report);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Edit a meal
exports.editMeal = async (req, res) => {
  try {
    const { date, mealId, updatedMeal } = req.body;

    const report = await DailyReport.findOneAndUpdate(
      { user: req.user.id, date, "meals.id": mealId },
      { $set: { "meals.$": updatedMeal } },
      { new: true }
    );
    if (!report) return res.status(404).json({ message: "Meal not found" });
    res.json(report);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Remove a meal
exports.removeMeal = async (req, res) => {
  try {
    const { date, mealId } = req.body;

    const report = await DailyReport.findOneAndUpdate(
      { user: req.user.id, date },
      { $pull: { meals: { id: mealId } } },
      { new: true }
    );
    if (!report) return res.status(404).json({ message: "Meal not found" });
    res.json(report);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// View a meal
exports.viewMeal = async (req, res) => {
  try {
    const { date, mealId } = req.query;

    const report = await DailyReport.findOne({ user: req.user.id, date });
    if (!report)
      return res.status(404).json({ message: "Daily report not found" });

    const meal = report.meals.find((meal) => meal.id === mealId);
    if (!meal) return res.status(404).json({ message: "Meal not found" });

    res.json(meal);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// View all reports
exports.viewReports = async (req, res) => {
  try {
    const reports = await DailyReport.find({ user: req.user.id });
    res.json(reports);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// View a single report
exports.viewReport = async (req, res) => {
  try {
    const { reportId } = req.params;

    const report = await DailyReport.findById(reportId);
    if (!report || report.user.toString() !== req.user.id) {
      return res.status(404).json({ message: "Report not found" });
    }
    res.json(report);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
