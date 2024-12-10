require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors({}));
// Middleware
app.use(express.json());

// Routes
app.use("/api/auth", require("./routes/auth_routes.js"));
app.use("/api/daily-goals", require("./routes/dailyGoalRoutes.js"));
app.use("/api/reports", require("./routes/dailyReportRoutes.js"));
app.use("/api/recipes", require("./routes/recipeRoutes.js"));
app.use("/api/users", require("./routes/userRoutes.js"));

// Connect to MongoDB
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.error("MongoDB Connection Error:", err));

// Start the server
const PORT = process.env.PORT || 5022;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
