import 'package:diet_tracker/features/Profile/presentation/pages/profile_page.dart';
import 'package:diet_tracker/features/home/presentation/widgets/bottom_bar.dart';
import 'package:diet_tracker/features/recpies/presentation/pages/recipes_page.dart';
import 'package:diet_tracker/features/reports/pages/weight_tracker_page.dart';
import 'package:flutter/material.dart';
import '../widgets/nutrients_indicator.dart';
import '../widgets/water_intake_widget.dart';
import 'add_meal_page.dart';
import 'meal_stats_page.dart';

class TrackingPage extends StatefulWidget {
  final String token;
  const TrackingPage({super.key, required this.token});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int _currentIndex = 1; // Default to Home

  // State variables for the Home Page
  int calories = 0;
  int proteins = 0;
  int carbs = 0;
  int fats = 0;
  double waterIntake = 0.0;
  DateTime? selectedDate;
  List<Map<String, dynamic>> meals = [];

  // Add a meal
  void addMeal(Map<String, dynamic> meal) {
    setState(() {
      calories += (meal['calories'] as int);
      proteins += (meal['proteins'] as int);
      carbs += (meal['carbs'] as int);
      fats += (meal['fats'] as int);
      meals.add(meal);
    });
  }

  // Delete a meal
  void deleteMeal(int index) {
    setState(() {
      calories -= meals[index]['calories'] as int;
      proteins -= meals[index]['proteins'] as int;
      carbs -= meals[index]['carbs'] as int;
      fats -= meals[index]['fats'] as int;
      meals.removeAt(index);
    });
  }

  String formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    // Pages for navigation
    final List<Widget> pages = [
      Center(child: RecipesPage()),
      buildHomePage(), // Home Page
      Center(child: WeightTrackerPage()),
    ];

    return Scaffold(
      body: pages[_currentIndex], // Display the selected page
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // Build the Home Page with all widgets
  Widget buildHomePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with profile picture, name, and calendar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(token: widget.token)),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("assets/user_placeholder.jpg"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage(token: widget.token)),
                        );
                      },
                      child: Text(
                        "John Doe", // Replace with dynamic name if needed
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 28,
                    color: Colors.blueGrey[700],
                  ),
                  onPressed: () async {
                    final DateTime now = DateTime.now();
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? now,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Nutrients Indicator Card
            Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: NutrientsIndicator(
                  calories: calories,
                  proteins: proteins,
                  carbs: carbs,
                  fats: fats,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Water Intake Card
            Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: WaterIntakeWidget(
                  waterIntake: waterIntake,
                  onAdd: () => setState(
                      () => waterIntake = (waterIntake + 0.1).clamp(0.0, 2.5)),
                  onSubtract: () => setState(
                      () => waterIntake = (waterIntake - 0.1).clamp(0.0, 2.5)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Meals List
            ...meals.asMap().entries.map((entry) {
              final index = entry.key;
              final meal = entry.value;
              return Card(
                color: Colors.white,
                elevation: 4.0,
                margin: const EdgeInsets.only(bottom: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  title: Text(
                    meal['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Added at: ${formatTime(meal['time'])}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => deleteMeal(index),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealStatsPage(meal: meal),
                      ),
                    );
                  },
                ),
              );
            }),

            // Add Meal Button
            ElevatedButton(
              onPressed: () async {
                final meal = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddMealPage()),
                );
                if (meal != null) {
                  addMeal(meal);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              child: Text("Add Meal"),
            ),
          ],
        ),
      ),
    );
  }
}
