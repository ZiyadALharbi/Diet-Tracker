const Recipe = require("../models/recipe.js");

exports.addRecipe = async (req, res) => {
  try {
    const {
      name,
      description,
      calories,
      proteins,
      fats,
      carbs,
      grams,
      photo,
      videoLink,
    } = req.body;

    // Validate required fields
    if (
      !name ||
      !description ||
      !calories ||
      !proteins ||
      !fats ||
      !carbs ||
      !grams
    ) {
      return res
        .status(400)
        .json({ message: "All required fields must be provided" });
    }

    // Create a new recipe
    const recipe = await Recipe.create({
      name,
      description,
      calories,
      proteins,
      fats,
      carbs,
      grams,
      photo,
      videoLink,
    });

    res.status(201).json({ message: "Recipe added successfully", recipe });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// View all recipes
exports.viewRecipes = async (req, res) => {
  try {
    const recipes = await Recipe.find();
    res.json(recipes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.viewRecipeById = async (req, res) => {
  try {
    const { id } = req.params; // Extract the ID from the URL parameters

    // Find the recipe by its ID
    const recipe = await Recipe.findById(id);

    if (!recipe) {
      return res.status(404).json({ message: "Recipe not found" });
    }

    res.json(recipe);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// Search recipes
exports.searchRecipe = async (req, res) => {
  try {
    const { query } = req.query;

    const recipes = await Recipe.find({
      name: { $regex: query, $options: "i" }, // Case-insensitive search
    });
    res.json(recipes);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteRecipe = async (req, res) => {
  try {
    const { id } = req.params; // Get the recipe ID from the request parameters

    // Check if the recipe exists
    const recipe = await Recipe.findById(id);
    if (!recipe) {
      return res.status(404).json({ message: "Recipe not found" });
    }

    // Delete the recipe
    await Recipe.findByIdAndDelete(id);

    res.status(200).json({ message: "Recipe deleted successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
