import 'package:flutter/material.dart';

class MealsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> meals;

  const MealsWidget({super.key, this.meals = const []});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: meals.isEmpty
          ? const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("No meals added"),
        ),
      )
          : ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          return ListTile(
            title: Text(meal['name']),
            subtitle: Text("${meal['calories']} Cal"),
          );
        },
      ),
    );
  }
}
