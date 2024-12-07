import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();

  bool _isVideoEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Image URL Field
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Calories Field
              TextFormField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Calories',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Protein Field
              TextFormField(
                controller: _proteinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Protein (g)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Fat Field
              TextFormField(
                controller: _fatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fat (g)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Carbs Field
              TextFormField(
                controller: _carbsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Carbs (g)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Enable Video Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _isVideoEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isVideoEnabled = value!;
                      });
                    },
                  ),
                  Text('Add Video URL'),
                ],
              ),
              // Video URL Field
              TextFormField(
                controller: _videoUrlController,
                enabled: _isVideoEnabled,
                decoration: InputDecoration(
                  labelText: 'Video URL',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save the recipe (logic to add recipe)
                    print('Recipe Saved: ${_nameController.text}');
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
