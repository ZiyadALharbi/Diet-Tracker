import 'dart:convert';
import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/forgot_password/send_code_page.dart';
import 'package:diet_tracker/features/home/presentation/pages/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  String password = "";
  bool _isLoading = false;

  final GetStorage _storage = GetStorage(); 

  Future<void> _login() async {
    final email = emailController.text.trim();
    debugPrint("Attempting login with email: $email and password: $password");

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in all fields', Colors.red);
      debugPrint("Validation failed: Missing email or password");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse(
          'http://localhost:5022/api/auth/login'); // Replace with your backend URL
      debugPrint("Sending POST request to: $url");

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Login successful, received token: ${data['token']}");

        // Store the token using GetStorage
        _storage.write('auth_token', data['token']);
        debugPrint("Token stored: ${_storage.read('auth_token')}");

        _showMessage('Login successful!', Colors.green);

        // Navigate to TrackerPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  TrackingPage()), // Replace with your TrackerPage widget
        );
      } else {
        final errorData = jsonDecode(response.body);
        debugPrint(
            "Login failed: ${errorData['message'] ?? 'Unknown error occurred'}");
        _showMessage(errorData['message'] ?? 'Login failed', Colors.red);
      }
    } catch (error) {
      debugPrint("Error during login: $error");
      _showMessage('An error occurred: $error', Colors.red);
    } finally {
      setState(() {
        _isLoading = false;
      });
      debugPrint("Login process completed");
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
    debugPrint("Snackbar displayed with message: $message");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("LoginPage built");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            CustomTextField(
              hint: "Email@gmail.com",
              label: "Email",
              icon: Icons.email_outlined,
              controller: emailController,
            ),
            CustomTextField(
              hint: "Az593@fb",
              label: "Password",
              icon: Icons.lock_outline_rounded,
              isPassword: true,
              onChanged: (value) {
                password = value;
                debugPrint("Password updated: $password");
              },
            ),
            const Spacer(),
            _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SendCodePage(),
                            ),
                          );
                          debugPrint("Navigating to SendCodePage");
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}




// import 'package:diet_tracker/core/utils/custom_text_field.dart';
// import 'package:diet_tracker/features/Auth/presentation/pages/forgot_password/send_code.dart';
// import 'package:diet_tracker/features/Auth/presentation/widgets/login_page/login_button.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   String password = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Login"),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Spacer(),
//                CustomTextField(
//                   hint: "Email@gmail.com",
//                   label: "Email",
//                   icon: Icons.email_outlined,
//                   controller: emailController,
//                   ),
//               CustomTextField(
//                 hint: "Az593@fb",
//                 label: "Password",
//                 icon: Icons.lock_outline_rounded,
//                 isPassword: true,
//                 onChanged: (value) {
//                   password = value;
//                 },
//               ),
//               const Spacer(),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const LoginButton(),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SendCodePage(),
//                         ),
//                       );
//                     },
//                     child: const Text("Forgot Password?"),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
