import 'package:diet_tracker/features/Auth/data/models/user_mode.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/user_setup_page.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final UserModel user;
  const RegisterButton({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
              builder: (context) => UserSetupPage(user: user),
            ),
          );
        },
        child: const Text(
          "Register",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
