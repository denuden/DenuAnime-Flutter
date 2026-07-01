import 'package:flutter/material.dart';

class AuthTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType type;

  const AuthTextfield({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPassword,
    required this.suffixIcon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
      enableSuggestions: !isPassword,
      obscureText: isPassword,
      keyboardType: type,
    );
  }
}
