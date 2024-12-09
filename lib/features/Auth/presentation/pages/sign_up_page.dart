import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/data/models/user_mode.dart';
import 'package:diet_tracker/features/userSetup/presentation/pages/user_setup_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  String username = "";
  String password = "";

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, "0")}-${pickedDate.day.toString().padLeft(2, "0")}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(), // Push content towards the center
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                    hint: "Ziyad Alharbi",
                    label: "Name",
                    icon: Icons.person_outline_rounded,
                    controller: nameController),
                CustomTextField(
                  hint: "Ziyad_1440",
                  label: "Username",
                  icon: Icons.account_circle_outlined,
                  onChanged: (value) {
                    username = value;
                  },
                ),
                CustomTextField(
                  hint: "email@gmail.com",
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
                  },
                ),
              ],
            ),
            const Spacer(), // Push content towards the center
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  final user = UserModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    username: username.trim(),
                    password: password.trim(),
                  );

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
            ),
          ],
        ),
      ),
    );
  }
}
