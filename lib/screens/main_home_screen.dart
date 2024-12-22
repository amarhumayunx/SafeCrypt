import 'package:flutter/material.dart';
import 'package:safecrypt/colors/colors.dart';
import 'dart:math';
import 'package:safecrypt/screens/create_vault_screen.dart' as create_vault_screen;
import 'package:safecrypt/screens/help_screen.dart';
import 'package:safecrypt/screens/sign_in_screen.dart' as sign_in_screen;

class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Set the background color to white
          Positioned.fill(
            child: Container(
              color: Colors.white, // Set background to white
            ),
          ),

          // Add wave animation
          Positioned.fill(
            child: WaveLinesAnimation(),
          ),

          // Centered main content with modern styling
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // App logo with fade-in effect
                    FadeInAnimation(
                      delay: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.security, size: 56, color: AppColors.primarySwatch), // Placeholder icon
                          SizedBox(width: 10),
                          AnimatedTextLogo(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Encrypt. Protect. Secure.',
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primarySwatch, // Adjusted color for better contrast
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 50),

                    // Button to create a new vault with scale animation
                    Tooltip(
                      message: 'Create a secure new vault',
                      child: ScaleAnimationButton(
                        text: 'Create a New Vault',
                        onPressed: () async {
                          await _showLoadingSpinner(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => create_vault_screen.CreateVaultScreen()),
                            );
                          });
                        },
                        color: AppColors.primarySwatch,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Button to sign in to an existing vault with scale animation
                    Tooltip(
                      message: 'Sign in to your existing vault',
                      child: ScaleAnimationButton(
                        text: 'Sign In to your Vault',
                        onPressed: () async {
                          await _showLoadingSpinner(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sign_in_screen.SignInScreen()),
                            );
                          });
                        },
                        color: AppColors.secondary,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Help & Support button with a subtle slide-up animation
                    FadeInAnimation(
                      delay: 0.5,
                      child: Tooltip(
                        message: 'Get help and support',
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HelpScreen()),
                            );
                          },
                          child: Text(
                            'Help & Support',
                            style: TextStyle(
                              color: AppColors.primarySwatch, // Adjusted color for contrast
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
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

  Future<void> _showLoadingSpinner(BuildContext context, VoidCallback action) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: CircularProgressIndicator()),
    );
    await Future.delayed(Duration(seconds: 1)); // Simulate a delay
    Navigator.of(context).pop(); // Close the dialog
    action();
  }
}

// AnimatedTextLogo Widget
class AnimatedTextLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'SafeCrypt',
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary, // Adjusted color for better contrast
        letterSpacing: 3,
      ),
    );
  }
}

// FadeInAnimation Widget
class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final double delay;

  const FadeInAnimation({required this.child, this.delay = 0.0});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 1),
      curve: Curves.easeIn,
      child: child,
    );
  }
}

// ScaleAnimationButton Widget with scale effect
class ScaleAnimationButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const ScaleAnimationButton({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  _ScaleAnimationButtonState createState() => _ScaleAnimationButtonState();
}

class _ScaleAnimationButtonState extends State<ScaleAnimationButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.color.withOpacity(0.8), widget.color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 10,
              ),
            ],
          ),
          width: double.infinity,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// WaveLinesAnimation Widget
class WaveLinesAnimation extends StatefulWidget {
  @override
  _WaveLinesAnimationState createState() => _WaveLinesAnimationState();
}

class _WaveLinesAnimationState extends State<WaveLinesAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WaveLinesPainter(_controller.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WaveLinesPainter extends CustomPainter {
  final double progress;

  WaveLinesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.2)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (int i = 0; i < 5; i++) {
      final offset = (progress + i * 0.2) % 1;
      final startX = centerX - 100 + i * 40;
      final waveHeight = sin(offset * 2 * pi) * 20;
      canvas.drawLine(
        Offset(startX, centerY - waveHeight),
        Offset(startX, centerY + waveHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
