import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/presentation/pages/forgot_password/send_code.dart';
import 'package:diet_tracker/features/Auth/presentation/widgets/login_page/login_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  String password = "";
  @override
  Widget build(BuildContext context) {
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
                },
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LoginButton(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SendCodePage(),
                        ),
                      );
                    },
                    child: const Text("Forgot Password?"),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
