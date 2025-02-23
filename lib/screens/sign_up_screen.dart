import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safecrypt/colors/colors.dart';
import 'package:safecrypt/screens/dashboard_screen.dart';
import 'package:safecrypt/screens/sign_in_screen.dart';
import 'package:safecrypt/screens/help_screen.dart';
import 'package:safecrypt/theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:validators/validators.dart'; // Add this at the top
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
  bool _isLoading = false;
  bool isPasswordVisible = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.security, size: 70, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  'SafeCrypt',
                  style: TextStyle(
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
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
                      Text(
                        'Begin Your Journey to Digital Security!',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      _buildTextField('Full Name', 'Enter Full Name', false, fullNameController),
                      const SizedBox(height: 25.0),
                      _buildEmailField(),
                      const SizedBox(height: 25.0),
                      _buildPasswordField(),
                      const SizedBox(height: 25.0),
                      _buildAgreeCheckbox(),
                      const SizedBox(height: 25.0),
                      _buildSignUpButton(),
                      const SizedBox(height: 30.0),
                      _buildSignInRedirect(),
                      const SizedBox(height: 20.0),
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
  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email], // Auto-suggest email
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        }
        if (!isEmail(value.trim())) { // More accurate validation
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email, color: AppColors.secondary), // Adds an email icon
        filled: true,
        fillColor: Colors.grey[300], // Softer background color
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Better spacing
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28), // Smooth rounded corners
          borderSide: BorderSide.none, // Removes default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.white, width: 2), // Light border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2), // Highlighted when focused
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.red, width: 2), // Red border for errors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
      ),
    );
  }
  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible, // Toggle based on state
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        final passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
        if (!passwordRegex.hasMatch(value)) {
          return 'Password must include uppercase, lowercase, number, and special character';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock, color: AppColors.secondary), // Lock icon for better UX
        filled: true,
        fillColor: Colors.grey[300], // Softer background color for modern look
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Proper spacing
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18), // Smooth rounded corners
          borderSide: BorderSide.none, // Removes default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.white, width: 2), // Light border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2), // Highlighted when focused
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.red, width: 2), // Red border for errors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        suffixIcon: AnimatedSwitcher(
          duration: Duration(milliseconds: 300), // Smooth transition effect
          child: IconButton(
            key: ValueKey<bool>(isPasswordVisible), // Prevents widget rebuilding issues
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.secondary,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible; // Toggle visibility
              });
            },
          ),
        ),
      ),
    );
  }

  // Custom method to build text fields
  Widget _buildTextField(String label, String hint, bool isPasswordField, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField ? !isPasswordVisible : false, // Handle visibility toggle
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == "Email" && !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (label == "Password" && value.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.blueGrey[700], // Subtle label color for a modern look
          fontWeight: FontWeight.w500, // Slightly bold for better readability
        ),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black38, // Slightly darker hint color for better contrast
          fontSize: 14, // Adjusted for a sleek UI
        ),
        filled: true,
        fillColor: Colors.grey[300], // Softer background for a premium feel
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Better spacing
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28), // More rounded for a modern touch
          borderSide: BorderSide.none, // Removes default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.white, width: 1), // Light border for inactive state
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2), // Highlighted when active
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.red, width: 2), // Red border for errors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
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
          activeColor: AppColors.secondary,
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
      onPressed: _isLoading
          ? null
          : () {
              if (_formSignupKey.currentState!.validate() && agreePersonalData) {
                setState(() {
                  _isLoading = true;
                });

                _signUpUser();
              } else if (!agreePersonalData) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please agree to the processing of personal data'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isLoading ? Colors.grey : lightColorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      child: _isLoading
          ? LoadingAnimationWidget.dotsTriangle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.blueAccent
                  : Colors.white,
              size: 30,
            )
          : const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28), // Success Icon
            SizedBox(width: 10),
            Text('Success', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'Your account has been created successfully.',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green, // Custom Button Color
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                CustomPageRoute(page: DashboardPage()),
              );
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white), // White text for contrast
            ),
          ),
        ],
      );
    },
  );
}

}
