import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safecrypt/screens/main_home_screen.dart';
import 'package:safecrypt/screens/sign_in_screen.dart'; // Import login screen
// Import sign-up screen
import 'package:safecrypt/colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Firebase initialization
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyCNVwMBhHKtBCHz5buAUoJsU--zTzx_HnE",
          authDomain: "safecrypt-x9.firebaseapp.com",
          projectId: "safecrypt-x9",
          storageBucket: "safecrypt-x9.firebasestorage.app",
          messagingSenderId: "427635113344",
          appId: "1:427635113344:web:c35c6b60c485daa80f9565",
          measurementId: "G-6MWK222Q4W",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCrypt Password Manager',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LetsGetStartedScreen(),
    );
  }
}

class LetsGetStartedScreen extends StatefulWidget {
  @override
  _LetsGetStartedScreenState createState() => _LetsGetStartedScreenState();
}

class _LetsGetStartedScreenState extends State<LetsGetStartedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  User? user;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: const Offset(0.0, -0.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Check if the user is already logged in
    checkUserStatus();
  }

  // Check user authentication status
  Future<void> checkUserStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    setState(() {
      user = currentUser;
    });

    if (user != null) {
      // If the user is logged in, navigate to the main screen
      if (user!.email == "administrator@example.com") {
        // Admin specific flow
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHomeScreen()), // Admin Dashboard
        );
      } else {
        // Normal user flow
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHomeScreen()), // User Dashboard
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Wave Animation
          const Positioned.fill(
            child: WaveAnimation(),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Name with Secure Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.security,
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'SafeCrypt',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Icon in the center
                SlideTransition(
                  position: _animation,
                  child: const Icon(
                    Icons.security,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Slogan Text
                const Text(
                  'Your Secure Vault for Passwords and More',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 30),
                // Divider line
                const Divider(
                  color: Colors.white,
                  thickness: 1.5,
                  indent: 40,
                  endIndent: 40,
                ),
                const SizedBox(height: 30),
                const Text(
                  'Let\'s Get Started',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Button to move to the main screen
                AnimatedButton(
                  text: 'Get Started',
                  onPressed: () {
                    // Navigate to login or sign-up page based on user status
                    if (user == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainHomeScreen()),
                      );
                    }
                  },
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({Key? key}) : super(key: key);

  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _waveAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primarySwatch, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomPaint(
            painter: WavePainter(progress: _waveAnimation.value),
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;

  WavePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(0, size.height - 100 * progress);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(i, size.height - 100 * progress +
          (10 * (i / size.width) * (i / size.width)));
    }
    path.lineTo(size.width, size.height - 100 * progress);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class AnimatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const AnimatedButton({
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        width: 200,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
