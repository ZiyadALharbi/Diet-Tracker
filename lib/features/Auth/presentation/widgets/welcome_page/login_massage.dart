import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginMassage extends StatelessWidget {
  const LoginMassage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
        children: [
          TextSpan(
            text: "Sign In",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
        ],
      ),
    );
  }
}
