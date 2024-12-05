import 'package:diet_tracker/features/userSetup/presentation/pages/activity_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/age_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/gender_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/goal_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/height_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/weight_page.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/activation_page.dart'; // Import Activation Page
import 'package:flutter/material.dart';

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({super.key});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToNextPage(BuildContext context) {
    if (_currentPage < 5) { // If not the last page, go to next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else { // On the last page, navigate to Activation Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ActivationPage(),
        ),
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _goToPreviousPage,
              )
            : null,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: const [
          GoalPage(),
          GenderPage(),
          ActivityPage(),
          HeightPage(),
          WeightPage(),
          AgePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNextPage(context), // Pass context to the function
        shape: const CircleBorder(),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
        ),
      ),
    );
  }
}

