import 'package:flutter/material.dart';
import '../../domain/recipe_model.dart';
import '../../data/recipe_repository.dart';
import 'add_recipe_page.dart';
import 'recipe_details_page.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final RecipeRepository repository =
      RecipeRepository(baseUrl: 'http://localhost:5022/api/recipes');
  late Future<List<Recipe>> recipesFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> filteredRecipes = [];
  List<Recipe> allRecipes = [];

  @override
  void initState() {
    super.initState();
    recipesFuture = _fetchRecipesWithDebugging();
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Recipe>> _fetchRecipesWithDebugging() async {
    try {
      debugPrint("Fetching recipes from the server...");
      final recipes = await repository.fetchRecipes();
      setState(() {
        allRecipes = recipes;
        filteredRecipes = recipes; // Initially, all recipes are displayed
      });
      debugPrint("Successfully fetched ${recipes.length} recipes.");
      return recipes;
    } catch (error) {
      debugPrint("Error fetching recipes: $error");
      rethrow; // Re-throw the error to display it in the UI
    }
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = allRecipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query) ||
              recipe.description.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _refreshRecipes() async {
    setState(() {
      recipesFuture = _fetchRecipesWithDebugging();
    });
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
                hintText: 'Search for recipes...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: recipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  debugPrint("Error in FutureBuilder: ${snapshot.error}");
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load recipes.'),
                        Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshRecipes,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (filteredRecipes.isEmpty) {
                  return const Center(
                    child: Text('No recipes available.'),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refreshRecipes,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];
                      return GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecipeDetailsPage(recipe: recipe),
                            ),
                          );
                          if (result == true) {
                            // Refresh recipes if a recipe was deleted
                            _refreshRecipes();
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 5,
                          child: Stack(
                            children: [
                              // Recipe Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: recipe.photo != null
                                    ? Image.network(
                                        recipe.photo!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.grey,
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
                                      recipe.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${recipe.calories} Calories',
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
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipePage()),
          ).then((_) => _refreshRecipes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../../domain/recipe_model.dart';
// import '../../data/recipe_repository.dart';
// import 'add_recipe_page.dart';

// class RecipesPage extends StatefulWidget {
//   const RecipesPage({super.key});

//   @override
//   _RecipesPageState createState() => _RecipesPageState();
// }

// class _RecipesPageState extends State<RecipesPage> {
//   final RecipeRepository repository =
//       RecipeRepository(baseUrl: 'http://localhost:5022/api/recipes');
//   late Future<List<Recipe>> recipesFuture;
//   final TextEditingController _searchController = TextEditingController();
//   List<Recipe> filteredRecipes = [];
//   List<Recipe> allRecipes = [];

//   @override
//   void initState() {
//     super.initState();
//     recipesFuture = _fetchRecipesWithDebugging();
//     _searchController.addListener(_filterRecipes);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<List<Recipe>> _fetchRecipesWithDebugging() async {
//     try {
//       debugPrint("Fetching recipes from the server...");
//       final recipes = await repository.fetchRecipes();
//       setState(() {
//         allRecipes = recipes;
//         filteredRecipes = recipes; // Initially, all recipes are displayed
//       });
//       debugPrint("Successfully fetched ${recipes.length} recipes.");
//       return recipes;
//     } catch (error) {
//       debugPrint("Error fetching recipes: $error");
//       rethrow; // Re-throw the error to display it in the UI
//     }
//   }

//   void _filterRecipes() {
//     final query = _searchController.text.toLowerCase();
//     setState(() {
//       filteredRecipes = allRecipes
//           .where((recipe) =>
//               recipe.name.toLowerCase().contains(query) ||
//               recipe.description.toLowerCase().contains(query))
//           .toList();
//     });
//   }

//   Future<void> _refreshRecipes() async {
//     setState(() {
//       recipesFuture = _fetchRecipesWithDebugging();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recipes'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Icon(Icons.kitchen),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for recipes...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(Icons.search),
//               ),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<Recipe>>(
//               future: recipesFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   debugPrint("Error in FutureBuilder: ${snapshot.error}");
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Failed to load recipes.'),
//                         Text(
//                           'Error: ${snapshot.error}',
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: _refreshRecipes,
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else if (filteredRecipes.isEmpty) {
//                   return const Center(
//                     child: Text('No recipes available.'),
//                   );
//                 }

//                 return RefreshIndicator(
//                   onRefresh: _refreshRecipes,
//                   child: GridView.builder(
//                     padding: const EdgeInsets.all(16.0),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.8,
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 16,
//                     ),
//                     itemCount: filteredRecipes.length,
//                     itemBuilder: (context, index) {
//                       final recipe = filteredRecipes[index];
//                       return GestureDetector(
//                         onTap: () {
//                           // Navigate to recipe details page
//                         },
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           elevation: 5,
//                           child: Stack(
//                             children: [
//                               // Recipe Image
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(16),
//                                 child: recipe.photo != null
//                                     ? Image.network(
//                                         recipe.photo!,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                         fit: BoxFit.cover,
//                                       )
//                                     : const Icon(
//                                         Icons.image_not_supported,
//                                         size: 80,
//                                         color: Colors.grey,
//                                       ),
//                               ),
//                               // Gradient Overlay
//                               Positioned.fill(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.black.withOpacity(0.6),
//                                         Colors.transparent,
//                                       ],
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.topCenter,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               // Recipe Name and Calories
//                               Positioned(
//                                 bottom: 16,
//                                 left: 16,
//                                 right: 16,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       recipe.name,
//                                       style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     Text(
//                                       '${recipe.calories} Calories',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.white70,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddRecipePage()),
//           ).then((_) => _refreshRecipes());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';
// import '../../data/recipe_repository.dart';
// import '../../domain/recipe_model.dart';
// import 'add_recipe_page.dart';

// class RecipesPage extends StatefulWidget {
//   const RecipesPage({super.key});

//   @override
//   _RecipesPageState createState() => _RecipesPageState();
// }

// class _RecipesPageState extends State<RecipesPage> {
//   final RecipeRepository repository =
//       RecipeRepository(baseUrl: 'http://localhost:5022/api/recipes');
//   late Future<List<Recipe>> recipesFuture;

//   @override
//   void initState() {
//     super.initState();
//     recipesFuture = _fetchRecipesWithDebugging();
//   }

//   Future<List<Recipe>> _fetchRecipesWithDebugging() async {
//     try {
//       debugPrint("Fetching recipes from the server...");
//       final recipes = await repository.fetchRecipes();
//       debugPrint("Successfully fetched ${recipes.length} recipes.");
//       return recipes;
//     } catch (error) {
//       debugPrint("Error fetching recipes: $error");
//       rethrow; // Re-throw the error to display it in the UI
//     }
//   }

//   Future<void> _refreshRecipes() async {
//     setState(() {
//       recipesFuture = _fetchRecipesWithDebugging();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Recipes')),
//       body: FutureBuilder<List<Recipe>>(
//         future: recipesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             debugPrint("Error in FutureBuilder: ${snapshot.error}");
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Failed to load recipes.'),
//                   Text(
//                     'Error: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _refreshRecipes,
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             debugPrint("No recipes found.");
//             return const Center(child: Text('No recipes available.'));
//           }

//           final recipes = snapshot.data!;
//           debugPrint("Displaying ${recipes.length} recipes in the UI.");
//           return RefreshIndicator(
//             onRefresh: _refreshRecipes,
//             child: ListView.builder(
//               itemCount: recipes.length,
//               itemBuilder: (context, index) {
//                 final recipe = recipes[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8.0),
//                   child: ListTile(
//                     leading: recipe.photo != null
//                         ? Image.network(recipe.photo!,
//                             width: 50, height: 50, fit: BoxFit.cover)
//                         : const Icon(Icons.image_not_supported),
//                     title: Text(recipe.name),
//                     subtitle: Text('${recipe.calories} Calories'),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddRecipePage()),
//           ).then((_) => _refreshRecipes());
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import '../../data/recipe_repository.dart';
// import '../../data/recipe.dart';
// import 'recipe_details_page.dart';
// import 'add_recipe_page.dart'; // Import the AddRecipePage

// class RecipesPage extends StatefulWidget {
//   const RecipesPage({super.key});

//   @override
//   _RecipesPageState createState() => _RecipesPageState();
// }

// class _RecipesPageState extends State<RecipesPage> {
//   List<Recipe> displayedRecipes = RecipeRepository.getRecipes();
//   final TextEditingController _searchController = TextEditingController();

//   void _filterRecipes() {
//     String query = _searchController.text.toLowerCase();
//     setState(() {
//       displayedRecipes = RecipeRepository.getRecipes()
//           .where((recipe) => recipe.name.toLowerCase().contains(query) ?? false)
//           .toList();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_filterRecipes);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _openAddRecipeForm() async {
//     final newRecipe = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AddRecipePage()),
//     );

//     if (newRecipe != null && newRecipe is Recipe) {
//       setState(() {
//         RecipeRepository.getRecipes()
//             .add(newRecipe); // Add the new recipe to the list
//         _filterRecipes(); // Reapply the filter to include the new recipe
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recipes'),
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search for recipes',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 prefixIcon: const Icon(Icons.search),
//               ),
//             ),
//           ),
//           // Recipe List
//           Expanded(
//             child: ListView.builder(
//               itemCount: displayedRecipes.length,
//               itemBuilder: (context, index) {
//                 final Recipe recipe = displayedRecipes[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RecipeDetailsPage(recipe: recipe),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     margin:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     elevation: 5,
//                     child: Stack(
//                       children: [
//                         // Recipe Image
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(16),
//                           child: Image.asset(
//                             '/Users/ziyadalharbi/Downloads/Diet-Tracker-main/assets/images/Kabab.jpg',
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         // Gradient Overlay
//                         Positioned.fill(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.black.withOpacity(0.6),
//                                   Colors.transparent,
//                                 ],
//                                 begin: Alignment.bottomCenter,
//                                 end: Alignment.topCenter,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Recipe Name and Calories
//                         Positioned(
//                           bottom: 16,
//                           left: 16,
//                           right: 16,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 recipe.name ?? 'Unnamed Recipe',
//                                 style: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 '${recipe.calories} Cal',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.white70,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _openAddRecipeForm,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
