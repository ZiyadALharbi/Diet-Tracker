import 'package:flutter/material.dart';
import '../../data/recipe_repository.dart';
import '../../data/recipe.dart';
import 'recipe_details_page.dart';
import 'add_recipe_page.dart'; // Import the AddRecipePage

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<Recipe> displayedRecipes = RecipeRepository.getRecipes();
  final TextEditingController _searchController = TextEditingController();

  void _filterRecipes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      displayedRecipes = RecipeRepository.getRecipes()
          .where((recipe) => recipe.name.toLowerCase().contains(query) ?? false)
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAddRecipeForm() async {
    final newRecipe = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRecipePage()),
    );

    if (newRecipe != null && newRecipe is Recipe) {
      setState(() {
        RecipeRepository.getRecipes().add(newRecipe); // Add the new recipe to the list
        _filterRecipes(); // Reapply the filter to include the new recipe
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for recipes',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          // Recipe List
          Expanded(
            child: ListView.builder(
              itemCount: displayedRecipes.length,
              itemBuilder: (context, index) {
                final Recipe recipe = displayedRecipes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsPage(recipe: recipe),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    child: Stack(
                      children: [
                        // Recipe Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            recipe.image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Gradient Overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        // Recipe Name and Calories
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name ?? 'Unnamed Recipe',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${recipe.calories} Cal',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddRecipeForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
