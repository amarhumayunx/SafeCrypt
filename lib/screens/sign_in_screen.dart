import 'package:flutter/material.dart';
import 'package:safecrypt/screens/sign_up_screen.dart';
import 'package:safecrypt/widgets/custom_scaffold.dart';
import '../theme/theme.dart';
import 'package:safecrypt/custom_page_route.dart';
import 'package:safecrypt/screens/dashboard_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          // Top Spacer
          const SizedBox(height: 50.0),
          // App Name and Slogan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo or Security Icon
                Icon(
                  Icons.security,
                  size: 70,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                // App Name
                Text(
                  'SafeCrypt',
                  style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                // App Slogan
                Text(
                  'Encrypt. Protect. Secure.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          // Main Form Section
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Welcome Text
                      Text(
                        'Lets Pick Up Where We Left Off!',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      // Email Field
                      _buildTextField('Email', 'Enter Email', false),
                      const SizedBox(height: 25.0),
                      // Password Field
                      _buildTextField('Password', 'Enter Password', true),
                      const SizedBox(height: 25.0),
                      // Sign In Button
                      _buildSignInButton(),
                      const SizedBox(height: 30.0),
                      // Don't have an account? Redirect
                      _buildSignUpRedirect(),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom method to build text fields
  Widget _buildTextField(String label, String hint, bool obscureText) {
    return TextFormField(
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.primary),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // Custom method to build the Sign In button
  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formSignInKey.currentState!.validate()) {
            // Show loading or processing message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );

            // Simulate some delay for processing (you can replace this with actual authentication logic)
            Future.delayed(Duration(seconds: 2), () {
              // Once authentication is successful, navigate to the Dashboard screen
              Navigator.pushReplacement(
                context,
                CustomPageRoute(page: DashboardPage()),
              );
            });
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Sign In', style: TextStyle(fontSize: 16.0)),
      ),
    );
  }

  // Custom method to build the sign-up redirect
  Widget _buildSignUpRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(color: Colors.black45),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(page: SignUpScreen()),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}