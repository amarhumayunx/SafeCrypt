import 'package:flutter/material.dart';
// Direct import without alias
import 'package:safecrypt/screens/sign_up_screen.dart';
import 'package:safecrypt/widgets/custom_scaffold.dart';

import '../theme/theme.dart'; // Assuming CustomScaffold exists

class HelpScreen extends StatelessWidget {
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

          // Main Help Content Section
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Welcome Text
                    Text(
                      'Welcome to SafeCrypt Help & Support!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: lightColorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Attractive Line Below the Welcome Text
                    Text(
                      'Your journey to secure digital freedom starts here — '
                          'we\'re here to guide you every step of the way!',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 40.0),

                    // How to Get Started Section
                    Text(
                      'How to Get Started:',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: lightColorScheme.primary),
                    ),
                    const SizedBox(height: 15),
                    _buildStepCard(
                      context,
                      icon: Icons.lock,
                      title: 'Create a New Account on SafeCrypt',
                      description: 'Tap to create a secure account to protect your data.',
                      targetScreen: SignUpScreen(),
                    ),
                    _buildStepCard(
                      context,
                      icon: Icons.lock,
                      title: 'Enter Your Email & Password',
                      description: 'Set your credentials to secure your account.',
                      targetScreen: SignUpScreen(),
                    ),
                    _buildStepCard(
                      context,
                      icon: Icons.login,
                      title: 'Sign Up for a SafeCrypt Account',
                      description: 'Don\'t have an account? Sign up to get started.',
                      targetScreen: SignUpScreen(),
                    ),
                    const SizedBox(height: 25),

                    // FAQs Section
                    Text(
                      'Frequently Asked Questions:',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: lightColorScheme.primary),
                    ),
                    const SizedBox(height: 15),
                    _buildFAQ(
                      question: 'Q: What should I do if I forget my password?',
                      answer:
                      'A: You can reset your password by tapping on the "Forgot Password" option on the Sign in screen.',
                    ),
                    _buildFAQ(
                      question: 'Q: How do I create a new vault?',
                      answer:
                      'A: Tap "Create New Vault" on the home screen and follow the instructions.',
                    ),
                    _buildFAQ(
                      question: 'Q: How do I sign up for a new account?',
                      answer:
                      'A: Tap on "Create New Vault" and follow the prompts to create your account and secure your vault.',
                    ),
                    _buildFAQ(
                      question: 'Q: How do I sign in to my account?',
                      answer:
                      'A: Enter your credentials (username and password) on the sign-in screen to access your vault.',
                    ),
                    _buildFAQ(
                      question: 'Q: Can I change my email or password later?',
                      answer:
                      'A: Yes, you can change your email or password from the "Account Settings" section in the app.',
                    ),
                    _buildFAQ(
                      question: 'Q: How secure is SafeCrypt?',
                      answer:
                      'A: SafeCrypt uses state-of-the-art encryption to ensure that your data is always secure and protected.',
                    ),
                    const SizedBox(height: 25),

                    // Contact Support Section with Icon
                    Text(
                      'Need More Help?',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: lightColorScheme.primary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.mail_outline, color: lightColorScheme.primary),
                        const SizedBox(width: 10),
                        Text(
                          'amarhumayun@outlook.com',
                          style: TextStyle(fontSize: 16, color: lightColorScheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Return to Home Button with a Modern Style
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Return to Home', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: lightColorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Method to Build Step Cards
  Widget _buildStepCard(BuildContext context, {required IconData icon, required String title, required String description, required Widget targetScreen}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, size: 40, color: lightColorScheme.primary),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: lightColorScheme.primary),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.blueAccent,
                thickness: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method to Build FAQ Section
  Widget _buildFAQ({required String question, required String answer}) {
    return Container(
      alignment: Alignment.centerLeft,  // Ensures alignment to the left
      padding: const EdgeInsets.symmetric(horizontal: 25.0), // Horizontal padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: lightColorScheme.primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            answer,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

}
