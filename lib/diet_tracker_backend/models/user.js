const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const userSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    age: { type: Number },
    height: { type: Number },
    weight: { type: Number },
    gender: { type: String, enum: ["male", "female"] },
    goal: {
      type: String,
      enum: ["lose weight", "keep weight", "gain weight"],
    },
    activity: {
      type: String,
      enum: ["sedentary", "low active", "active", "very active"],
    },
    avatar: { type: String },
    dailyGoals: {
      waterLiters: { type: Number, required: false },
      calories: { type: Number, required: false },
      fats: { type: Number, required: false },
      proteins: { type: Number, required: false },
      carbs: { type: Number, required: false },
    },
  },
  { timestamps: true }
);

// Compare passwords
userSchema.methods.comparePassword = async function (candidatePassword) {
  return bcrypt.compare(candidatePassword, this.password);
};

module.exports = mongoose.model("User", userSchema);
