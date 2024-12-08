import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  String _selectedActivity = "Active"; // Default selected activity level

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "How active are you?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "A sedentary person burns fewer calories than an active person",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _buildOption(context, "Sedentary"),
          _buildOption(context, "Low Active"),
          _buildOption(context, "Active"),
          _buildOption(context, "Very Active"),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    final bool isSelected = _selectedActivity == label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedActivity = label; // Update the selected activity
          });
        },
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white, // Background color
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 22,
              color: isSelected ? Colors.white : Colors.black, // Text color
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
