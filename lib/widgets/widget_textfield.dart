import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFeildWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  TextFormFeildWidget({
    this.hintText,
    required this.lableText,
    this.onChange,
    this.validator,
    this.onSave,
    this.onSubmit,
    this.suffixIcon,
    this.obscureText = false,
  });
  String? hintText;
  String? lableText;
  Function(String)? onChange;
  FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSave;
  FormFieldSetter<String>? onSubmit;
  // Function(String?)? onSave;
  Widget? suffixIcon;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      onChanged: onChange,
      validator: validator,
      onSaved: onSave,
      onFieldSubmitted: onSubmit,
      //  obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        label: Text(
          lableText ?? 'Error',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
