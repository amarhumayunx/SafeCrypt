//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:safecrypt/screens/splash_screen.dart';
import 'package:safecrypt/theme/theme.dart';
import 'package:safecrypt/website_save.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await websites_names.loadWebsites();

  try {
    // Firebase initialization for both Web and non-Web platforms
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
    print("Firebase Initialized successfully.");
  } catch (e) {
    print('Error initializing Firebase: $e');
    // You could show a user-friendly message or a retry option here
  }

  runApp(
        MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeCrypt Password Manager',
      theme: lightMode,
      home: const SplashScreen(),
    );
  }
}