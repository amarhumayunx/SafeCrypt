import 'package:flutter/material.dart';
import 'package:safecrypt/colors/colors.dart';
import 'package:safecrypt/screens/create_vault_screen.dart'; // Direct import without alias
import 'package:safecrypt/screens/sign_in_screen.dart'; // Direct import without alias


class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text('Help & Support', style: TextStyle(fontSize: 22)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Introduction Section with Image
              Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Welcome to SafeCrypt!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarySwatch,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This app allows you to securely store your sensitive '
                    'information in a protected vault. You can create a new vault or '
                    'sign in to an existing one.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 25),

              // Step-by-Step Instructions with Icons
              Text(
                'How to Get Started:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primarySwatch),
              ),
              SizedBox(height: 15),
              _buildStepCard(
                context,
                icon: Icons.lock,
                title: 'Create a New Vault',
                description: 'Tap to create a secure vault for data.',
                targetScreen: CreateVaultScreen(), // Navigate to CreateVaultScreen
              ),
              _buildStepCard(
                context,
                icon: Icons.lock,
                title: 'Enter Credentials',
                description: 'Set credentials to secure your vault.',
                targetScreen: CreateVaultScreen(), // Navigate to EnterCredentialsScreen
              ),
              _buildStepCard(
                context,
                icon: Icons.login,
                title: 'Sign In to Vault',
                description: 'Already have an account? Sign in.',
                targetScreen: SignInScreen(), // Navigate to SignInScreen
              ),
              SizedBox(height: 25),

              // FAQs Section
              Text(
                'Frequently Asked Questions:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primarySwatch),
              ),
              SizedBox(height: 15),
              _buildFAQ(
                question: 'Q: What should I do if I forget my password?',
                answer: 'A: You can reset your password by tapping on the "Forgot Password" option on the login screen.',
              ),
              _buildFAQ(
                question: 'Q: How do I create a new vault?',
                answer: 'A: Tap "Create New Vault" on the home screen and follow the instructions.',
              ),
              SizedBox(height: 25),

              // Contact Support Section with Icon
              Text(
                'Need More Help?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primarySwatch),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.mail_outline, color: AppColors.primarySwatch),
                  SizedBox(width: 10),
                  Text(
                    'amarhumayun@outlook.com',
                    style: TextStyle(fontSize: 16, color: AppColors.primarySwatch),
                  ),
                ],
              ),
              SizedBox(height: 25),

              // Return to Home Button with a Modern Style
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Return to Home', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarySwatch,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method to Build Step Cards
  Widget _buildStepCard(BuildContext context, {required IconData icon, required String title, required String description, required Widget targetScreen}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10),
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
                  Icon(icon, size: 40, color: AppColors.primarySwatch),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.secondary),
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          answer,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
