import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  ButtonWidget({
    required this.buttonText,
    required this.onTab,
  });

  String? buttonText;
  VoidCallback? onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            buttonText ?? 'Error',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
