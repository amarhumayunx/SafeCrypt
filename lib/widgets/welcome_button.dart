import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({
    super.key,
    required this.buttonText,
    required this.onTap,  // Changed to VoidCallback
    required this.color,
    required this.textColor,
    this.alignment,  // Optional alignment
  });

  final String buttonText;
  final VoidCallback onTap;  // Use VoidCallback instead of Widget
  final Color color;
  final Color textColor;
  final Alignment? alignment; // Optional alignment

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // Directly use the passed onTap callback
      child: Align(
        alignment: alignment ?? Alignment.center,  // Default to center if no alignment is provided
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
            ),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}