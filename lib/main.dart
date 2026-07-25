import 'package:flutter/material.dart';
import 'onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jura App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE6297A),
        scaffoldBackgroundColor: const Color(0xFFF9E1EC),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}