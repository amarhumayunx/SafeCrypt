import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safecrypt/screens/sign_in_screen.dart';
import 'package:safecrypt/screens/help_screen.dart';
import 'package:safecrypt/theme/theme.dart';
import 'package:safecrypt/widgets/custom_scaffold.dart';
import 'package:safecrypt/custom_page_route.dart'; // Import the custom page route

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final databaseReference = FirebaseDatabase.instance.ref("Users");

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          // Top Spacer
          const SizedBox(
            height: 50.0,
          ),
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
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Get Started Text
                      Text(
                        'Begin Your Journey to Digital Security!',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      // Full Name Field
                      _buildTextField('Full Name', 'Enter Full Name', false, fullNameController),
                      const SizedBox(height: 25.0),
                      // Email Field
                      _buildTextField('Email', 'Enter Email', false, emailController),
                      const SizedBox(height: 25.0),
                      // Password Field
                      _buildTextField('Password', 'Enter Password', true, passwordController),
                      const SizedBox(height: 25.0),
                      // I Agree Checkbox
                      _buildAgreeCheckbox(),
                      const SizedBox(height: 25.0),
                      // Sign Up Button
                      _buildSignUpButton(),
                      const SizedBox(height: 30.0),
                      // Already Have Account Text
                      _buildSignInRedirect(),
                      const SizedBox(height: 20.0),
                      // Help and Support Link
                      _buildHelpAndSupportLink(),
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
  Widget _buildTextField(String label, String hint, bool obscureText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  // Custom method to build agree checkbox
  Widget _buildAgreeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: agreePersonalData,
          onChanged: (bool? value) {
            setState(() {
              agreePersonalData = value!;
            });
          },
          activeColor: lightColorScheme.primary,
        ),
        const Text(
          'I agree to the processing of ',
          style: TextStyle(color: Colors.black45),
        ),
        Text(
          'Personal data',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: lightColorScheme.primary,
          ),
        ),
      ],
    );
  }

  // Custom method to build the Sign Up button
  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formSignupKey.currentState!.validate() && agreePersonalData) {
            // Create user with Firebase Authentication and save to Realtime Database
            _signUpUser();
          } else if (!agreePersonalData) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please agree to the processing of personal data')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: lightColorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Sign up', style: TextStyle(fontSize: 16.0)),
      ),
    );
  }

  // Custom method to build the sign-in redirect
  Widget _buildSignInRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.black45),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomPageRoute(page: SignInScreen()),  // Use the custom route
            );
          },
          child: Text(
            'Sign in',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  // Custom method to build Help and Support link
  Widget _buildHelpAndSupportLink() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(page: HelpScreen()),
        );
      },
      child: Text(
        'Help and Support',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: lightColorScheme.primary,
        ),
      ),
    );
  }

  // Method to sign up the user with Firebase Authentication and save data to Firebase Realtime Database
  void _signUpUser() async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Save user data to Firebase Realtime Database
      final fullName = fullNameController.text;
      final email = emailController.text;

      // Generate unique ID based on email (before '@' symbol)
      String uniqueUserId = email.split('@')[0];

      // Create a reference for the new user
      final newUserRef = databaseReference.child(uniqueUserId);

      // Save the user's data in Firebase
      newUserRef.set({
        'fullName': fullName,
        'email': email,
      }).then((_) {
        // Show a dialog for successful sign-up
        _showSuccessDialog();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),

        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An account with this email already exists. Please try logging in.')),
      );
      // Navigate to SignInScreen after showing the error message
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          CustomPageRoute(page: SignInScreen()),
        );
      });
    }
  }

  // Method to show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Up Successful'),
          content: Text('Your account has been created successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CustomPageRoute(page: SignInScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
