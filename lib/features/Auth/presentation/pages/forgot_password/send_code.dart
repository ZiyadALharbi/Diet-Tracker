import 'package:diet_tracker/core/utils/custom_text_field.dart';
import 'package:diet_tracker/features/Auth/presentation/widgets/forgot_password/send_code_button.dart';
import 'package:flutter/material.dart';

class SendCodePage extends StatefulWidget {
  const SendCodePage({super.key});

  @override
  State<SendCodePage> createState() => _SendCodePageState();
}

class _SendCodePageState extends State<SendCodePage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              "We will send a password reset code to your email account.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
              textAlign: TextAlign.center, // Center the text horizontally
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
                hint: "Email@gmail.com",
                label: "Email",
                icon: Icons.email_outlined,
                controller: emailController),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SendCodeButton(),
            ),
          ],
        ),
      ),
    );
  }
}
