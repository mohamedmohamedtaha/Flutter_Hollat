import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  const CustomTextField(
      {super.key,
        required this.controller,
        this.labelText = '',
        this.hintText = '',
        this.maxLength,
        this.obscureText = false,
        this.validator,
        this.keyboardType = TextInputType.text,
        this.prefixIcon,
        this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength ?? 100,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          // Standard border
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0) // Non-focused border
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10.0) // Focused border
          )),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
