import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safecrypt/colors/colors.dart';
import 'package:safecrypt/screens/sign_up_screen.dart';
import 'package:safecrypt/screens/sign_in_screen.dart';
import 'package:safecrypt/screens/dashboard_screen.dart';
import 'package:safecrypt/widgets/custom_scaffold.dart';
import 'package:safecrypt/widgets/gradient_button.dart'; // Import new Gradient Button

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus();
  }

  void _checkUserLoginStatus() {
    final auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 40.0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security,
                      size: 120,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SafeCrypt',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Encrypt. Protect. Secure.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome To SafeCrypt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Encrypt Your Data,\nProtect Your Information,\nSecure Your Access',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Gradient Sign In and Sign Up Buttons
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: GradientButton(
                      text: 'Sign In',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      },
                      gradientColors: [Colors.blueAccent,AppColors.secondary],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GradientButton(
                      text: 'Sign Up',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      gradientColors: [AppColors.primary,AppColors.secondary],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}