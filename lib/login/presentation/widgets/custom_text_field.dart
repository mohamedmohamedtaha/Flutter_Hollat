import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final bool filled;
  final bool readOnly;
  final void Function()? onTap;

  const CustomTextField({super.key,
    required this.controller,
    this.labelText = '',
    this.hintText = '',
    this.maxLength,
    this.maxLines,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.onChanged,
    this.fillColor,
    this.filled = false,
    this.readOnly = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLength: maxLength ,
      maxLines: maxLines ,
      readOnly: readOnly,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          filled: filled,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          // Standard border
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0) // Non-focused border
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor),
              borderRadius: BorderRadius.circular(10.0) // Focused border
          )),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
