
import 'package:flutter/material.dart';

class WelcomeMassage extends StatelessWidget {
  const WelcomeMassage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                return Text(
                  "Welcome",
                  style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                  textAlign: TextAlign.center,
                );
              },
            ),
            Builder(
              builder: (context) {
                return Text(
                  "Start or Sign in to your account",
                  style:
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                  textAlign: TextAlign.center,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
