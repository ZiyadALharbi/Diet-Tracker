import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:flutter/material.dart';

class AgePage extends StatelessWidget {
  const AgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What's your age?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Required number of calories varies with age.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          const CustomTextField(
            hint: "Enter your age",
            label: "Age",
            icon: Icons.calendar_today_outlined,
            suffixText: "Years",
          ),
        ],
      ),
    );
  }
}
