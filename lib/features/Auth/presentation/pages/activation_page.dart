import 'package:diet_tracker/features/Auth/presentation/widgets/activation_page/goto_login.dart';
import 'package:flutter/material.dart';

class ActivationPage extends StatelessWidget {
  const ActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(), // Push text to the center
            Text(
              "We have sent an account activation link to your email. Please activate your account before logging in.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
              textAlign: TextAlign.center, // Center the text horizontally
            ),
            const Spacer(), // Push buttons to the bottom
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GotoLogin(), // "Go to Login" button
                TextButton(
                  onPressed: () {
                    // Handle resend logic here
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
