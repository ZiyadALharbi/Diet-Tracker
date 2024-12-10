import 'package:diet_tracker/features/Profile/presentation/pages/profile_page.dart';
import 'package:diet_tracker/features/home/presentation/widgets/bottom_bar.dart';
import 'package:diet_tracker/features/recpies/presentation/pages/recipes_page.dart';
import 'package:diet_tracker/features/reports/pages/weight_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String userName = "Loading..."; // Initial placeholder for user name
  bool isLoading = true; // To control initial loading state

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchMeals();
  }

  Future<void> _fetchUserData() async {
    final storage = GetStorage();
    final token = storage.read('auth_token');

    try {
      final response = await http.get(
        Uri.parse('http://localhost:5022/api/users/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data['name'] ?? "User";
          isLoading = false;
        });
      } else {
        debugPrint("Failed to fetch user data: ${response.body}");
        setState(() {
          userName = "User"; // Fallback name
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
      setState(() {
        userName = "User"; // Fallback name
        isLoading = false;
      });
    }
  }

  Future<void> _fetchMeals() async {
    final storage = GetStorage();
    final token = storage.read('auth_token');

    try {
      final response = await http.get(
        Uri.parse('http://localhost:5022/api/reports/get-daily-reports'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          meals = (data['meals'] as List)
              .map((meal) => {
                    'name': meal['name'],
                    'calories': meal['calories'],
                    'proteins': meal['proteins'],
                    'carbs': meal['carbs'],
                    'fats': meal['fats'],
                    'time': DateTime.parse(meal['createdAt']),
                  })
              .toList();
        });
      } else {
        debugPrint("Failed to fetch meals: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error fetching meals: $e");
    }
  }

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
    final List<Widget> pages = [
      Center(child: RecipesPage()),
      buildHomePage(), // Home Page
      Center(child: WeightTrackerPage()),
    ];

    return Scaffold(
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loader until data is fetched
          : pages[_currentIndex],
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
                              builder: (context) =>
                                  ProfilePage(token: widget.token)),
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
                              builder: (context) =>
                                  ProfilePage(token: widget.token)),
                        );
                      },
                      child: Text(
                        userName, // Dynamically displays the user's name
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
              color: Theme.of(context).colorScheme.primary,
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
              color: Theme.of(context).colorScheme.primary,
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
            ...meals.map((meal) {
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
                  subtitle: Text("Calories: ${meal['calories']}"),
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
            }).toList(),

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
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text("Add Meal"),
            ),
          ],
        ),
      ),
    );
  }
}
