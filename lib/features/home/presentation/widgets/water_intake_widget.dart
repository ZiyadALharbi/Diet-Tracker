import 'package:flutter/material.dart';

class WaterIntakeWidget extends StatelessWidget {
  final double waterIntake; // Current water intake in liters
  final VoidCallback onAdd;
  final VoidCallback onSubtract;

  const WaterIntakeWidget({super.key, 
    required this.waterIntake,
    required this.onAdd,
    required this.onSubtract,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        (waterIntake / 2.5).clamp(0.0, 1.0); // Ensure it's between 0 and 1

    return Card(
      color: Colors.white,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Title
            Text(
              "Water Intake",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 16),

            // Circular Progress Indicator
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: percentage, // Progress based on water intake
                    strokeWidth: 8.0,
                    backgroundColor: Colors.grey[300]!,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blue, // Water color
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${waterIntake.toStringAsFixed(1)}L",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    Text(
                      "of 2.5L",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Buttons in the center
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  icon: Icons.remove,
                  onPressed: onSubtract,
                  color: Colors.grey, // Grey "-" icon
                  backgroundColor: Colors.grey[200]!, // Light grey background
                ),
                const SizedBox(width: 20), // Space between buttons
                _buildButton(
                  icon: Icons.add,
                  onPressed: onAdd,
                  color: Colors.grey, // Grey "+" icon
                  backgroundColor: Colors.grey[200]!, // Light grey background
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Custom Button Builder
  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    required Color backgroundColor,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Fixed nullable color issue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded edges
        ),
        elevation: 6.0, // Add shadow for attractiveness
        padding: const EdgeInsets.all(16.0), // Increase button size
      ),
      child: Icon(
        icon,
        size: 28,
        color: color, // Icon color (grey for "-" and "+")
      ),
    );
  }
}
