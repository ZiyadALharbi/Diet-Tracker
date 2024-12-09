import 'package:diet_tracker/features/userSetup/presentation/widgets/custom_user_setup_text_field.dart';
import 'package:flutter/material.dart';


class HeightPage extends StatelessWidget {
  final TextEditingController heightController;

  const HeightPage({super.key, required this.heightController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "How tall are you?",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "The taller you are, the more calories your body needs.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          CustomUserSetupTextField(
            hint: "Enter your height",
            label: "Height",
            icon: Icons.height_outlined,
            controller: heightController,
          ),
        ],
      ),
    );
  }
}



// import 'package:diet_tracker/core/utils/custom_text_field.dart';
// import 'package:flutter/material.dart';

// class HeightPage extends StatelessWidget {
//   const HeightPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "How tall are you?",
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                 ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "The taller you are, the more calories your body needs.",
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontSize: 14, fontWeight: FontWeight.w500, height: 1),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 18),
//           const CustomTextField(
//             hint: "Enter your height",
//             label: "Height",
//             icon: Icons.height_outlined,
//             suffixText: "cm",
//           ),
//         ],
//       ),
//     );
//   }
// }
