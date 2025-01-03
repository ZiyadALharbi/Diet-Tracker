import 'package:diet_tracker/features/Auth/presentation/pages/Login_page.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/forgot_password/reset_password.dart';
import 'package:flutter/material.dart';

class SendCodeButton extends StatelessWidget {
  const SendCodeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetPasswordPage(),
            ),
          );
        },
        child: const Text(
          "Send code",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}