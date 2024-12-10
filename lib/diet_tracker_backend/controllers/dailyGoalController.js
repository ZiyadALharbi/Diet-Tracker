// Add Daily Goals
exports.addDailyGoals = async (req, res) => {
  try {
    const { waterLiters, calories, fats, proteins, carbs } = req.body;

    // Find the user and update their daily goals
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    user.dailyGoals = { waterLiters, calories, fats, proteins, carbs };
    await user.save();

    res
      .status(201)
      .json({
        message: "Daily goals added successfully",
        dailyGoals: user.dailyGoals,
      });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Edit Daily Goals
exports.editDailyGoals = async (req, res) => {
  try {
    const { waterLiters, calories, fats, proteins, carbs } = req.body;

    // Find the user and update their daily goals
    const user = await User.findById(req.user.id);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    user.dailyGoals = { waterLiters, calories, fats, proteins, carbs };
    await user.save();

    res
      .status(200)
      .json({
        message: "Daily goals updated successfully",
        dailyGoals: user.dailyGoals,
      });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// View Daily Goals
exports.viewDailyGoals = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select("dailyGoals");
    if (!user || !user.dailyGoals) {
      return res.status(404).json({ message: "Daily goals not found" });
    }

    res.status(200).json(user.dailyGoals);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
