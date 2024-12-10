import 'package:flutter/material.dart';
import '../../data/recipe_repository.dart';
import '../../domain/recipe_model.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final RecipeRepository repository =
      RecipeRepository(baseUrl: 'http://localhost:5022/api/recipes');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _gramsController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final newRecipe = Recipe(
        id: '',
        name: _nameController.text,
        description: _descriptionController.text,
        calories: int.parse(_caloriesController.text),
        proteins: int.parse(_proteinController.text),
        fats: int.parse(_fatController.text),
        carbs: int.parse(_carbsController.text),
        grams: int.parse(_gramsController.text),
        photo: _photoController.text.isNotEmpty ? _photoController.text : null,
        videoLink: _videoUrlController.text.isNotEmpty
            ? _videoUrlController.text
            : null,
      );

      try {
        await repository.addRecipe(newRecipe);
        Navigator.pop(context, true);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add recipe: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, 'Recipe Name'),
              _buildTextField(_descriptionController, 'Description'),
              _buildTextField(_caloriesController, 'Calories', isNumber: true),
              _buildTextField(_proteinController, 'Proteins (g)',
                  isNumber: true),
              _buildTextField(_fatController, 'Fats (g)', isNumber: true),
              _buildTextField(_carbsController, 'Carbs (g)', isNumber: true),
              _buildTextField(_gramsController, 'Grams', isNumber: true),
              _buildTextField(_photoController, 'Photo URL'),
              _buildTextField(_videoUrlController, 'Video URL'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: const Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        validator: (value) =>
            value == null || value.isEmpty ? 'Field is required' : null,
      ),
    );
  }
}






// import 'package:flutter/material.dart';

// class AddRecipePage extends StatefulWidget {
//   const AddRecipePage({super.key});

//   @override
//   _AddRecipePageState createState() => _AddRecipePageState();
// }

// class _AddRecipePageState extends State<AddRecipePage> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _imageController = TextEditingController();
//   final TextEditingController _caloriesController = TextEditingController();
//   final TextEditingController _proteinController = TextEditingController();
//   final TextEditingController _fatController = TextEditingController();
//   final TextEditingController _carbsController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _videoUrlController = TextEditingController();

//   bool _isVideoEnabled = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Recipe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Name Field
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Recipe Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a recipe name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               // Image URL Field
//               TextFormField(
//                 controller: _imageController,
//                 decoration: const InputDecoration(
//                   labelText: 'Image URL',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Calories Field
//               TextFormField(
//                 controller: _caloriesController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Calories',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Protein Field
//               TextFormField(
//                 controller: _proteinController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Protein (g)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Fat Field
//               TextFormField(
//                 controller: _fatController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Fat (g)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Carbs Field
//               TextFormField(
//                 controller: _carbsController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: 'Carbs (g)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Description Field
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(
//                   labelText: 'Description',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               // Enable Video Checkbox
//               Row(
//                 children: [
//                   Checkbox(
//                     value: _isVideoEnabled,
//                     onChanged: (value) {
//                       setState(() {
//                         _isVideoEnabled = value!;
//                       });
//                     },
//                   ),
//                   const Text('Add Video URL'),
//                 ],
//               ),
//               // Video URL Field
//               TextFormField(
//                 controller: _videoUrlController,
//                 enabled: _isVideoEnabled,
//                 decoration: const InputDecoration(
//                   labelText: 'Video URL',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               // Submit Button
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Save the recipe (logic to add recipe)
//                     print('Recipe Saved: ${_nameController.text}');
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Save Recipe'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
