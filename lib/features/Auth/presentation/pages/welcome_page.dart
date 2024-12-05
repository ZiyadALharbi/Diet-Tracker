import 'package:diet_tracker/features/Auth/presentation/widgets/welcome_page/login_massage.dart';
import 'package:diet_tracker/features/Auth/presentation/widgets/welcome_page/start_button.dart';
import 'package:diet_tracker/features/Auth/presentation/widgets/welcome_page/welcome_massage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WelcomeMassage(), // i created it here THEN Extracted the widget from the WelcomePage Widget.
            StartButton(), // i created it here THEN Extracted the widget from the WelcomePage Widget.
            LoginMassage(), // i created it here THEN Extracted the widget from the WelcomePage Widget.
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
