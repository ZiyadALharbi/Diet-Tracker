const express = require("express");
const {
  viewRecipes,
  viewRecipeById,
  searchRecipe,
  addRecipe,
  deleteRecipe,
} = require("../controllers/recipeController.js");

const router = express.Router();

router.get("/view-recipes", viewRecipes);
router.get("/recipe/:id", viewRecipeById);
router.get("/search", searchRecipe);
router.post("/add-recipe", addRecipe);
router.delete("/delete-recipe/:id", deleteRecipe);

module.exports = router;
