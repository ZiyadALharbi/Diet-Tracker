import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  final void Function(String gender) onGenderSelected; // Callback for gender

  const GenderPage({super.key, required this.onGenderSelected});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String _selectedGender = "male"; // Default selected gender

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What's your gender?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Male bodies need more calories",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _buildOption(context, "male"),
          _buildOption(context, "female"),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    final bool isSelected = _selectedGender == label;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = label; // Update the selected gender
          });
          widget.onGenderSelected(label); // Trigger callback
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

// class GenderPage extends StatefulWidget {
//   const GenderPage({super.key});

//   @override
//   State<GenderPage> createState() => _GenderPageState();
// }

// class _GenderPageState extends State<GenderPage> {
//   String _selectedGender = "Male"; // Default selected gender

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "What's your gender?",
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "Male bodies need more calories",
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyMedium
//                 ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//           const Spacer(),
//           _buildOption(context, "Male"),
//           _buildOption(context, "Female"),
//           const Spacer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(BuildContext context, String label) {
//     final bool isSelected = _selectedGender == label;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedGender = label; // Update the selected gender
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
