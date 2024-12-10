import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/forgot_password/code_checking_page.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: "Enter new password",
              label: "New password",
              icon: Icons.lock_outline,
              isPassword: true,
              controller: _newPasswordController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: "Repeat new password",
              label: "Repeat password",
              icon: Icons.lock_outline,
              isPassword: true,
              controller: _repeatPasswordController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Validate and handle password reset
                if (_newPasswordController.text.isEmpty ||
                    _repeatPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in both fields."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_newPasswordController.text !=
                    _repeatPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Passwords do not match."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CodeCheckingPage(),
                  ),
                );
                // Password reset logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Reset",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
