
import 'package:flutter/material.dart';

class CustomUserSetupTextField extends StatelessWidget {
  final String hint;
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomUserSetupTextField({
    super.key,
    required this.hint,
    required this.label,
    this.icon,
    this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200, // Light background color
          hintText: hint,
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
            borderSide: BorderSide.none, // No visible border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.blue, // Highlight border when focused
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
