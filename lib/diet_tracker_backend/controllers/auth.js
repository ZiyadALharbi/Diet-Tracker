const User = require("../models/user.js");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
// Generate JWT
const generateToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, { expiresIn: "7d" });
};

// Sign Up
exports.signup = async (req, res) => {
  try {
    const {
      name,
      email,
      username,
      password,
      age = "",
      height = "",
      weight = "",
      gender = "",
      goal = "",
      activity = "",
      avatar = "",
    } = req.body;

    console.log("111")
    // Check if user exists
    const userExists = await User.findOne({ email });
    if (userExists)
      return res.status(400).json({ message: "User already exists" });
      console.log("222")

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    console.log("333")
    // Create new user
    const user = await User.create({
      name,
      email,
      username,
      password: hashedPassword, // Store hashed password
      age,
      height,
      weight,
      gender,
      goal,
      activity,
      avatar,
    });

    console.log("444")

    if (!process.env.JWT_SECRET) {
      throw new Error("JWT_SECRET is not defined in the environment variables");
    }

    console.log("555")
    res.status(201).json({
      message: "User registered successfully",
      token: generateToken(user._id), // Generate token for the user
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Login
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ message: "User not found" });

    // Check password
    const isMatch = await user.comparePassword(password);
    if (!isMatch)
      return res.status(401).json({ message: "Invalid credentials" });

    res.json({
      message: "Login successful",
      token: generateToken(user._id),
      user: { id: user._id, name: user.name, email: user.email },
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get User Details
exports.getUserDetails = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select("-password");
    if (!user) return res.status(404).json({ message: "User not found" });

    res.json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Change Password
exports.changePassword = async (req, res) => {
  try {
    const { currentPassword, newPassword } = req.body;

    // Find user
    const user = await User.findById(req.user.id);
    if (!user) return res.status(404).json({ message: "User not found" });

    // Check current password
    const isMatch = await user.comparePassword(currentPassword);
    if (!isMatch)
      return res.status(401).json({ message: "Current password is incorrect" });

    // Update password
    user.password = newPassword;
    await user.save();

    res.json({ message: "Password updated successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Add/Update User Details
exports.addOrUpdateDetails = async (req, res) => {
  try {
    const { age, height, weight, gender, goal, activity } = req.body;

    // Validate gender, goal, and activity (if provided)
    const validGenders = ["male", "female"];
    const validGoals = ["lose weight", "keep weight", "gain weight"];
    const validActivities = [
      "sedentary",
      "low active",
      "active",
      "high active",
    ];

    if (gender && !validGenders.includes(gender)) {
      return res.status(400).json({ message: "Invalid gender" });
    }

    if (goal && !validGoals.includes(goal)) {
      return res.status(400).json({ message: "Invalid goal" });
    }

    if (activity && !validActivities.includes(activity)) {
      return res.status(400).json({ message: "Invalid activity" });
    }

    // Update the user details
    const updatedUser = await User.findByIdAndUpdate(
      req.user.id,
      {
        ...(age !== undefined && { age }),
        ...(height !== undefined && { height }),
        ...(weight !== undefined && { weight }),
        ...(gender !== undefined && { gender }),
        ...(goal !== undefined && { goal }),
        ...(activity !== undefined && { activity }),
      },
      { new: true } // Return the updated user
    );

    if (!updatedUser) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({
      message: "User details updated successfully",
      user: updatedUser,
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
