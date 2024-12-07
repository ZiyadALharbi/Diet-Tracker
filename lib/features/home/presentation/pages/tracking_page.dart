import 'package:flutter/material.dart';
import '../widgets/nutrients_indicator.dart';
import '../widgets/water_intake_widget.dart';
import 'add_meal_page.dart';
import 'meal_stats_page.dart';

class TrackingPage extends StatefulWidget {
  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  int calories = 0;
  int proteins = 0;
  int carbs = 0;
  int fats = 0;
  double waterIntake = 0.0;
  DateTime? selectedDate;

  List<Map<String, dynamic>> meals = [];

  void addMeal(Map<String, dynamic> meal) {
    setState(() {
      calories += (meal['calories'] as int);
      proteins += (meal['proteins'] as int);
      carbs += (meal['carbs'] as int);
      fats += (meal['fats'] as int);
      meals.add(meal);
    });
  }

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

  void openCalendar(BuildContext context) async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header with circular picture, name, and calendar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            "assets/user_placeholder.jpg"), // Replace with actual image
                      ),
                      SizedBox(width: 16),
                      Text(
                        "John Doe", // Replace with dynamic name if needed
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today,
                        size: 28, color: Colors.blueGrey[700]),
                    onPressed: () => openCalendar(context),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Nutrients Indicator Card
              Card(
                color: Colors.white, // Set the card's background color to white
                elevation: 4.0, // Add shadow
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
              SizedBox(height: 20),

              // Water Intake Card
              Card(
                color: Colors.white, // Set the card's background color to white
                elevation: 4.0, // Add shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: WaterIntakeWidget(
                    waterIntake: waterIntake,
                    onAdd: () => setState(() =>
                        waterIntake = (waterIntake + 0.1).clamp(0.0, 2.5)),
                    onSubtract: () => setState(() =>
                        waterIntake = (waterIntake - 0.1).clamp(0.0, 2.5)),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Meals List
              ...meals.asMap().entries.map((entry) {
                final index = entry.key;
                final meal = entry.value;
                return Card(
                  color:
                      Colors.white, // Set the card's background color to white
                  elevation: 4.0,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(meal['name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Added at: ${formatTime(meal['time'])}"),
                    trailing: IconButton(
                      icon: Icon(Icons.close,
                          color: Colors.red), // "X" delete button
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
                child: Text("Add Meal"),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
