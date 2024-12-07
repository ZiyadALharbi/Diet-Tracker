import 'recipe.dart';

class RecipeRepository {
  static final List<Recipe> recipes = [
    Recipe(
      name: 'Kabsa',
      image: 'assets/kabsa.jpg',
      calories: 743,
      protein: 50,
      fat: 20,
      carbs: 70,
      time: 60,
      description: 'Kabsa is a traditional Middle Eastern dish made with rice, meat, and spices.',
      videoUrl:"https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    ),
    Recipe(
      name: 'Kabab Sandwich',
      image: 'assets/kabab.jpg',
      calories: 498,
      protein: 36,
      fat: 20,
      carbs: 23,
      time: 60,
      description: 'A delicious Kabab sandwich with tender meat, fresh vegetables, and creamy sauce.',
      videoUrl:null,
    ),
    Recipe(
      name: 'Shawarma',
      image: 'assets/shawarma.jpg',
      calories: 600,
      protein: 40,
      fat: 15,
      carbs: 50,
      time: 45,
      description: 'A flavorful shawarma wrap filled with marinated meat, pickles, and tahini sauce.',
      videoUrl:null,
    ),
  ];

  static List<Recipe> getRecipes() {
    return recipes;
  }
}
