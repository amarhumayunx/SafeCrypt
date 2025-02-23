import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safecrypt/colors/colors.dart';
import 'package:safecrypt/screens/sign_up_screen.dart';
import 'package:safecrypt/screens/dashboard_screen.dart';
import 'package:safecrypt/widgets/custom_scaffold.dart';
import '../theme/theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safecrypt/custom_page_route.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const SizedBox(height: 80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.security,
                  size: 70,
                  color: Colors.white,
                ),
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
          const SizedBox(height: 60.0),
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
                      Text(
                        'Let\'s Pick Up Where We Left Off!',
                        style: TextStyle(
                          fontSize: 24.7,
                          fontWeight: FontWeight.w400,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      _buildEmailField(),
                      const SizedBox(height: 25.0),
                      _buildPasswordField(),
                      const SizedBox(height: 25.0),
                      _buildSignInButton(),
                      const SizedBox(height: 30.0),
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

  // Custom method for the Email TextField
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.primary),
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }

  // Custom method for the Password TextField
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !isPasswordVisible,
      obscuringCharacter: '*',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(28),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: lightColorScheme.primary),
          borderRadius: BorderRadius.circular(28),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.secondary,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _isLoading ? null : _signInUser,
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
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
          : const Text('Sign In', style: TextStyle(fontSize: 16.0)),
    ),
  );
}


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

  Future<void> _signInUser() async {
    if (_formSignInKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (userCredential.user != null) {
          // Navigate to the dashboard page if the user is successfully signed in
          Navigator.pushReplacement(
            context,
            CustomPageRoute(page: DashboardPage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email. Please sign up first.';
          Navigator.push(
            context,
            CustomPageRoute(page: SignUpScreen()),
          );
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        // Catch any other errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred. Please try again.')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      // If form is invalid, show a general validation error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid email and password.')),
      );
    }
  }
}