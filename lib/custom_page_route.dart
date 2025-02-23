import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget page;

  CustomPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Define the animations with smoother timing
      var begin = Offset(1.0, 0.0);  // Slide from the right
      var end = Offset.zero;
      var curve = Curves.easeInOut; // Smooth curve for the slide transition
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Scale animation with a smooth easing curve
      var scaleTween = Tween(begin: 0.95, end: 1.0);
      var scaleAnimation = animation.drive(scaleTween);

      // Fade animation with a smooth easing curve
      var fadeTween = Tween(begin: 0.0, end: 1.0);
      var fadeAnimation = animation.drive(fadeTween);

      // Combine all animations: Slide + Scale + Fade with a smoother transition
      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        ),
      );
    },
    transitionDuration: Duration(milliseconds: 600), // Adjust the duration for smoothness
    reverseTransitionDuration: Duration(milliseconds: 500), // Same duration for reverse transition
  );
}