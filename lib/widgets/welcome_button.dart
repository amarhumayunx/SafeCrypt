import 'package:flutter/material.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton(
      {super.key, this.buttonText, this.onTap, this.color, this.textColor, this.alignment});

  final String? buttonText;
  final Widget? onTap;
  final Color? color;
  final Color? textColor;
  final Alignment? alignment; // Added alignment property

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (e) => onTap!,
          ),
        );
      },
      child: Align(  // Use Align widget to control the alignment of the button
        alignment: alignment ?? Alignment.center,  // Default to center if no alignment is provided
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),  // Adjusted padding
          margin: EdgeInsets.zero,  // Remove margin if any
          decoration: BoxDecoration(
            color: color!,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
            ),
          ),
          child: Text(
            buttonText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: textColor!,
            ),
          ),
        ),
      ),
    );
  }
}
