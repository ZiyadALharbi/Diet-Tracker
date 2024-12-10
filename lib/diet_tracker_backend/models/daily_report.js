const mongoose = require("mongoose");

const dailyReportSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
    date: { type: Date, required: true, default: Date.now },
    waterLiters: { type: Number, required: true },
    calories: { type: Number, required: true },
    fats: { type: Number, required: true },
    proteins: { type: Number, required: true },
    carbs: { type: Number, required: true },
    totalGrams: { type: Number, required: true },
    meals: [
      {
        id: { type: String, required: true },
        name: { type: String, required: true },
        grams: { type: Number, required: true },
        calories: { type: Number, required: true },
        fats: { type: Number, required: true },
        proteins: { type: Number, required: true },
        carbs: { type: Number, required: true },
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("DailyReport", dailyReportSchema);
