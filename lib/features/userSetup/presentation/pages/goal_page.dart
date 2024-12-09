import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget {
  final void Function(String goal) onGoalSelected; // Callback to update goal

  const GoalPage({super.key, required this.onGoalSelected});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  String _selectedGoal = "keep weight"; // Default selected goal

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What's your goal?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "We will calculate daily calories according to your goal",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _buildOption(context, "lose weight"),
          _buildOption(context, "keep weight"),
          _buildOption(context, "gain weight"),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    final bool isSelected = _selectedGoal == label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGoal = label; // Update the selected goal
          });
          widget.onGoalSelected(label); // Trigger callback
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


// import 'package:flutter/material.dart';

// class GoalPage extends StatefulWidget {
//   const GoalPage({super.key});

//   @override
//   State<GoalPage> createState() => _GoalPageState();
// }

// class _GoalPageState extends State<GoalPage> {
//   String _selectedGoal = "Gain weight"; // Default selected goal

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "What's your goal?",
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "We will calculate daily calories according to your goal",
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium
//                 ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//           const Spacer(),
//           _buildOption(context, "Lose weight"),
//           _buildOption(context, "Keep weight"),
//           _buildOption(context, "Gain weight"),
//           const Spacer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(BuildContext context, String label) {
//     final bool isSelected = _selectedGoal == label;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedGoal = label; // Update the selected goal
//           });
//         },
//         child: Container(
//           width: double.infinity,
//           height: 50,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? Theme.of(context).colorScheme.primary
//                 : Colors.white, // Background color
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 22,
//               color: isSelected ? Colors.white : Colors.black, // Text color
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
