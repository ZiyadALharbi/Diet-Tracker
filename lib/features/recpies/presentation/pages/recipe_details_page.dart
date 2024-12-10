import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../domain/recipe_model.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsPage({super.key, required this.recipe});

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteRecipe(BuildContext context) async {
    final url = Uri.parse(
        'http://localhost:5022/api/recipes/delete-recipe/${recipe.id}');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe deleted successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Go back to RecipesPage and refresh
      } else {
        _showErrorDialog(context, 'Failed to delete the recipe.');
      }
    } catch (error) {
      debugPrint('Error deleting recipe: $error');
      _showErrorDialog(context, 'An error occurred while deleting the recipe.');
    }
  }

  Future<void> _openVideoLink(context, String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri); // Open in external application
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      debugPrint('Error launching URL: $error');
      _showErrorDialog(context, 'Failed to open the video link.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deleteRecipe(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: recipe.photo != null
                  ? Image.network(
                      recipe.photo!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),
            // Recipe Name
            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Nutritional Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip('Calories', '${recipe.calories} Cal'),
                _buildInfoChip('Protein', '${recipe.proteins}g'),
                _buildInfoChip('Fat', '${recipe.fats}g'),
                _buildInfoChip('Carbs', '${recipe.carbs}g'),
              ],
            ),
            const SizedBox(height: 16),
            // Recipe Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 32),
            // Watch Video Button
            Center(
              child: ElevatedButton(
                onPressed: recipe.videoLink != null
                    ? () => _openVideoLink(context, recipe.videoLink!)
                    : null, // Disabled if no video URL
                style: ElevatedButton.styleFrom(
                  backgroundColor: recipe.videoLink != null
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey, // Grey if disabled
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  recipe.videoLink != null
                      ? 'Watch Video Tutorial'
                      : 'No Video Available',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../data/recipe.dart';

// class RecipeDetailsPage extends StatelessWidget {
//   final Recipe recipe;

//   const RecipeDetailsPage({super.key, required this.recipe});

//   // Function to open the video link
//   Future<void> _openVideoLink(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(recipe.name ?? 'Recipe Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Recipe Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 "/Users/ziyadalharbi/Downloads/Diet-Tracker-main/assets/images/Kabab.jpg",
//                 width: double.infinity,
//                 height: 250,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // Recipe Name
//             Text(
//               recipe.name ?? '',
//               style: const TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             // Nutritional Info
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildInfoChip('Calories', '${recipe.calories} Cal'),
//                 _buildInfoChip('Protein', '${recipe.protein}g'),
//                 _buildInfoChip('Fat', '${recipe.fat}g'),
//                 _buildInfoChip('Carbs', '${recipe.carbs}g'),
//               ],
//             ),
//             const SizedBox(height: 16),
//             // Recipe Description
//             const Text(
//               'Description',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               recipe.description,
//               style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//             ),
//             const SizedBox(height: 32),
//             // Watch Video Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: recipe.videoUrl != null
//                     ? () => _openVideoLink(recipe.videoUrl!)
//                     : null, // Disabled if no video URL
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: recipe.videoUrl != null
//                       ? Colors.blue
//                       : Colors.grey, // Grey if disabled
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   recipe.videoUrl != null
//                       ? 'Watch Video Tutorial'
//                       : 'No Video Available',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoChip(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         const SizedBox(height: 4),
//         Text(value, style: const TextStyle(fontSize: 16)),
//       ],
//     );
//   }
// }
