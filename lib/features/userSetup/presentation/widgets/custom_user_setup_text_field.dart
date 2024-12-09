import 'package:flutter/material.dart';

class CustomUserSetupTextField extends StatefulWidget {
  final String hint;
  final String label;
  final IconData? icon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool isPassword;
  final String? suffixText; // Optional suffix text

  const CustomUserSetupTextField({
    super.key,
    required this.hint,
    required this.label,
    this.icon,
    this.controller,
    this.onChanged,
    this.isPassword = false,
    this.suffixText,
  });

  @override
  State<CustomUserSetupTextField> createState() =>
      _CustomUserSetupTextFieldState();
}

class _CustomUserSetupTextFieldState extends State<CustomUserSetupTextField> {
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2), // Shadow color
              blurRadius: 6, // How soft the shadow is
              offset: const Offset(0, 4), // Position of the shadow (x, y)
            ),
          ],
        ),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ? obscurePassword : false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: widget.hint,
            labelText: widget.label,
            floatingLabelStyle: const TextStyle(
              color: Color(0xFF0077B6), // Label color when focused
              fontSize: 20,
            ),
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: const Color(0xCC6E7179),
                    size: 22,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  )
                : null,
            suffixText: widget.suffixText, // Adding suffix text
            suffixStyle: const TextStyle(
              color: Color(0xFF6E7179),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6E7179),
            ),
            hintStyle: const TextStyle(
              color: Color(0x996E7179),
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4),
                width: 0.2, // Gray border
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              borderSide: BorderSide(
                color: Colors.blueGrey.withOpacity(0.4),
                width: 1.2, // Blue border
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(0.4), // Gray border
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.4),
                width: 2, // Red border for errors
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.4),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
