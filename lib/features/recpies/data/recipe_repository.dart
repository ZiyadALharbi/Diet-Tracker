import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../domain/recipe_model.dart';

class RecipeRepository {
  final String baseUrl;

  RecipeRepository({required this.baseUrl});

  Future<List<Recipe>> fetchRecipes() async {
    final url = Uri.parse('$baseUrl/view-recipes');
    try {
      final response = await http.get(url);
      debugPrint("Response Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch recipes: ${response.body}');
      }
    } catch (error) {
      debugPrint("Error in fetchRecipes: $error");
      rethrow;
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try{
    final url = Uri.parse('$baseUrl/add-recipe');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(recipe.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add recipe');
    }
    } catch (error){
      debugPrint("Error in fetchRecipes: $error");
      rethrow;
    }
  }
}


// https://as1.ftcdn.net/v2/jpg/02/39/85/66/1000_F_239856626_yt4ruViaepp2T62L0SA9nSbH8yWQDhL2.jpg

// https://as1.ftcdn.net/v2/jpg/02/39/85/66/1000_F_239856626_yt4ruViaepp2T62L0SA9nSbH8yWQDhL2.jpg

// Kabsa is a traditional Middle Eastern dish made with rice, meat, and spices.


// import 'recipe.dart';

// class RecipeRepository {
//   static final List<Recipe> recipes = [
//     Recipe(
//       name: 'Kabsa',
//       image: 'assets/images/kabsa.jpg',
//       calories: 743,
//       protein: 50,
//       fat: 20,
//       carbs: 70,
//       time: 60,
//       description:
//           'Kabsa is a traditional Middle Eastern dish made with rice, meat, and spices.',
//       videoUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
//     ),
//     Recipe(
//       name: 'Kabab Sandwich',
//       image: 'assets/images/kabab.jpg',
//       calories: 498,
//       protein: 36,
//       fat: 20,
//       carbs: 23,
//       time: 60,
//       description:
//           'A delicious Kabab sandwich with tender meat, fresh vegetables, and creamy sauce.',
//       videoUrl: null,
//     ),
//     Recipe(
//       name: 'Shawarma',
//       image: 'assets/images/shawarma.jpg',
//       calories: 600,
//       protein: 40,
//       fat: 15,
//       carbs: 50,
//       time: 45,
//       description:
//           'A flavorful shawarma wrap filled with marinated meat, pickles, and tahini sauce.',
//       videoUrl: null,
//     ),
//   ];

//   static List<Recipe> getRecipes() {
//     return recipes;
//   }
// }
