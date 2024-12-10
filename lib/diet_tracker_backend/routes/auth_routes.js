const express = require("express");
const {
  signup,
  login,
  getUserDetails,
  changePassword,
  addOrUpdateDetails,
} = require("../controllers/auth.js");
const { protect } = require("../middleware/auth_middleware.js");
const router = express.Router();

router.post("/signup", signup);
router.post("/login", login);
router.get("/me", protect, getUserDetails);
router.post("/change-password", protect, changePassword);
router.put("/details", addOrUpdateDetails);

module.exports = router;
