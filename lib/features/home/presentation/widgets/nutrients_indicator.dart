import 'package:flutter/material.dart';

class NutrientsIndicator extends StatelessWidget {
  final int calories;
  final int proteins;
  final int carbs;
  final int fats;

  const NutrientsIndicator({super.key, 
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nutrients Indicator",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                  ),
                ),
                Icon(
                  Icons.health_and_safety,
                  color: Colors.blueGrey[800],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Proteins, Carbs, and Fats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutrientProgress(
                    "Proteins", proteins, 225, Colors.orange),
                _buildNutrientProgress("Carbs", carbs, 340, Colors.blue),
                _buildNutrientProgress("Fats", fats, 118, Colors.purple),
              ],
            ),
            const SizedBox(height: 20),

            // Calories Section
            Center(
              child: Text(
                "Calories",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700]),
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (calories / 3400).clamp(0.0, 1.0),
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "$calories / 3400 kcal",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientProgress(String label, int value, int max, Color color) {
    double progress = (value / max).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.blueGrey[800],
          ),
        ),
        const SizedBox(height: 6),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 12,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              height: 12,
              width: 70 * progress,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "$value / $max",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
