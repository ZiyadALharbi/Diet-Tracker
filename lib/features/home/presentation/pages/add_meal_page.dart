import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMealPage extends StatefulWidget {
  const AddMealPage({super.key});

  @override
  _AddMealPageState createState() => _AddMealPageState();
}

class _AddMealPageState extends State<AddMealPage> {
  final TextEditingController mealNameController = TextEditingController();
  int calories = 0;
  int proteins = 0;
  int carbs = 0;
  int fats = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Meal"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Name Input
              Text(
                "Meal Name",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: mealNameController,
                decoration: InputDecoration(
                  hintText: "e.g., Breakfast",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Calories Row
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: "Calories",
                      maxLength: 4,
                      onChanged: (value) => calories = int.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Proteins, Carbs, and Fats Row
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      label: "Proteins (g)",
                      maxLength: 3,
                      onChanged: (value) => proteins = int.tryParse(value) ?? 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInputField(
                      label: "Carbs (g)",
                      maxLength: 3,
                      onChanged: (value) => carbs = int.tryParse(value) ?? 0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildInputField(
                      label: "Fats (g)",
                      maxLength: 3,
                      onChanged: (value) => fats = int.tryParse(value) ?? 0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Add Meal Button
              SizedBox(
                width: double.infinity, // Full-width button
                child: ElevatedButton(
                  onPressed: () {
                    final now = DateTime.now();
                    Navigator.pop(context, {
                      'name': mealNameController.text,
                      'calories': calories,
                      'proteins': proteins,
                      'carbs': carbs,
                      'fats': fats,
                      'time': now,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Add Meal",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Add Existing Meal Button
              SizedBox(
                width: double.infinity, // Full-width button
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExistingMealPage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.grey), // Grey border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ).copyWith(
                    overlayColor: WidgetStateProperty.all(Colors.grey[200]), // Hover effect
                  ),
                  child: const Text(
                    "Add Existing Meal",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input Field Builder
  Widget _buildInputField({
    required String label,
    required int maxLength,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(maxLength),
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "Enter value",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}

// Dummy Page for Add Existing Meal
class AddExistingMealPage extends StatelessWidget {
  const AddExistingMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Existing Meal"),
        backgroundColor: Colors.blueGrey,
      ),
      body: const Center(
        child: Text(
          "This is the Add Existing Meal page.",
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ),
    );
  }
}
