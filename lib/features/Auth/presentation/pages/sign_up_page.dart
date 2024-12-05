import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/presentation/widgets/sign_up_page/next_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomTextField(
                    hint: "email@gmail.com",
                    label: "Email",
                    icon: Icons.email_outlined,
                    controller: emailController,
                  ),
                  CustomTextField(
                    hint: "dfjbhdb2435t",
                    label: "Password",
                    icon: Icons.wifi_password,
                    isPassword: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: NextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
