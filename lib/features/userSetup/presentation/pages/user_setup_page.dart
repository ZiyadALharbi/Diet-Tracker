import 'dart:convert';
import 'package:diet_tracker/features/Auth/data/auth_service.dart';
import 'package:diet_tracker/features/Auth/data/models/user_mode.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/goal_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/gender_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/activity_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/height_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/weight_page.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/age_page.dart';

class UserSetupPage extends StatefulWidget {
  final UserModel user;

  const UserSetupPage({super.key, required this.user});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final PageController _pageController = PageController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final AuthService _authService = AuthService(
      baseUrl:
          'http://localhost:5022/api/auth'); // Replace with your backend URL
  int _currentPage = 0;

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void _updateUserModel(String key, dynamic value) {
    setState(() {
      switch (key) {
        case 'goal':
          widget.user.goal = value;
          break;
        case 'gender':
          widget.user.gender = value;
          break;
        case 'activity':
          widget.user.activity = value;
          break;
        case 'height':
          widget.user.height = double.tryParse(value) ?? widget.user.height;
          break;
        case 'weight':
          widget.user.weight = double.tryParse(value) ?? widget.user.weight;
          break;
        case 'age':
          widget.user.age = int.tryParse(value) ?? widget.user.age;
          break;
      }
      print('Updated UserModel: ${widget.user.toJson()}');
    });
  }

  Future<void> _submitUserData() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Send data to the backend
      final response = await _authService.signup(widget.user.toJson());

      // Dismiss loading indicator
      if (mounted) Navigator.pop(context);

      // Show success message and navigate to activation page
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful: ${response['message']}')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Replace with your LoginPage widget
      );
    } catch (error) {
      // Dismiss loading indicator
      if (mounted) Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void _goToNextPage(BuildContext context) {
    if (_currentPage == 3) {
      // HeightPage
      final heightValue = double.tryParse(heightController.text);
      if (heightValue != null) {
        _updateUserModel('height', heightValue.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid height')),
        );
        return; // Prevent navigation if invalid input
      }
    } else if (_currentPage == 4) {
      // WeightPage
      final weightValue = double.tryParse(weightController.text);
      if (weightValue != null) {
        _updateUserModel('weight', weightValue.toString());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid weight')),
        );
        return; // Prevent navigation if invalid input
      }
    } else if (_currentPage == 5) {
      // AgePage
      final ageValue = int.tryParse(ageController.text);
      if (ageValue != null) {
        _updateUserModel('age', ageValue.toString());
        _submitUserData(); // Submit data on the last page
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid age')),
        );
        return; // Prevent navigation if invalid input
      }
    }

    if (_currentPage < 5) {
      _pageController.nextPage(
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
                onPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
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
        children: [
          GoalPage(onGoalSelected: (goal) => _updateUserModel('goal', goal)),
          GenderPage(
              onGenderSelected: (gender) => _updateUserModel('gender', gender)),
          ActivityPage(
              onActivitySelected: (activity) =>
                  _updateUserModel('activity', activity)),
          HeightPage(heightController: heightController),
          WeightPage(weightController: weightController),
          AgePage(ageController: ageController),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToNextPage(context),
        child: Icon(
          _currentPage < 5 ? Icons.arrow_forward_ios_rounded : Icons.check,
        ),
      ),
    );
  }
}





// import 'package:diet_tracker/features/Auth/data/models/user_mode.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/activity_page.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/age_page.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/gender_page.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/goal_page.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/height_page.dart';
// import 'package:diet_tracker/features/userSetup/presentation/pages/weight_page.dart';
// import 'package:diet_tracker/features/Auth/presentation/pages/activation_page.dart'; // Import Activation Page
// import 'package:flutter/material.dart';


// class UserSetupPage extends StatefulWidget {
//   final UserModel user;

//   const UserSetupPage({super.key, required this.user});

//   @override
//   State<UserSetupPage> createState() => _UserSetupPageState();
// }

// class _UserSetupPageState extends State<UserSetupPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   void _updateUserModel(String key, dynamic value) {
//     setState(() {
//       switch (key) {
//         case 'goal':
//           widget.user.goal = value;
//           break;
//         case 'gender':
//           widget.user.gender = value;
//           break;
//         case 'activity':
//           widget.user.activity = value;
//           break;
//         case 'height':
//           widget.user.height = double.tryParse(value);
//           break;
//         case 'weight':
//           widget.user.weight = double.tryParse(value);
//           break;
//         case 'age':
//           widget.user.age = int.tryParse(value);
//           break;
//       }
//     });
//   }

//   void _goToNextPage(BuildContext context) {
//     if (_currentPage < 5) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       _submitUserData();
//     }
//   }

//   void _submitUserData() async {
//     // API submission
//     print("User Data: ${widget.user.toJson()}");
//     // Call your API with widget.user.toJson()
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const ActivationPage(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: _currentPage > 0
//             ? IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: () {
//                   if (_currentPage > 0) {
//                     _pageController.previousPage(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   }
//                 },
//               )
//             : null,
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentPage = index;
//           });
//         },
//         children: [
//           GoalPage(onGoalSelected: (goal) => _updateUserModel('goal', goal)),
//           GenderPage(onGenderSelected: (gender) => _updateUserModel('gender', gender)),
//           ActivityPage(onActivitySelected: (activity) => _updateUserModel('activity', activity)),
//           HeightPage(onHeightEntered: (height) => _updateUserModel('height', height)),
//           WeightPage(onWeightEntered: (weight) => _updateUserModel('weight', weight)),
//           AgePage(onAgeEntered: (age) => _updateUserModel('age', age)),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _goToNextPage(context),
//         child: const Icon(Icons.arrow_forward_ios_rounded),
//       ),
//     );
//   }
// }





// class UserSetupPage extends StatefulWidget {
//    final UserModel user;
//   const UserSetupPage({super.key, required this.user});

//   @override
//   State<UserSetupPage> createState() => _UserSetupPageState();
// }

// class _UserSetupPageState extends State<UserSetupPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   void _goToNextPage(BuildContext context) {
//     if (_currentPage < 5) { // If not the last page, go to next page
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else { // On the last page, navigate to Activation Page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const ActivationPage(),
//         ),
//       );
//     }
//   }

//   void _goToPreviousPage() {
//     if (_currentPage > 0) {
//       _pageController.previousPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: _currentPage > 0
//             ? IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: _goToPreviousPage,
//               )
//             : null,
//       ),
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentPage = index;
//           });
//         },
//         children: const [
//           GoalPage(),
//           GenderPage(),
//           ActivityPage(),
//           HeightPage(),
//           WeightPage(),
//           AgePage(),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _goToNextPage(context), // Pass context to the function
//         shape: const CircleBorder(),
//         child: const Icon(
//           Icons.arrow_forward_ios_rounded,
//         ),
//       ),
//     );
//   }
// }

