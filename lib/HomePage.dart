
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color kBackground = Color(0xFFF9E1EC);
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 72, color: kPrimary),
            const SizedBox(height: 16),
            const Text(
              "You're logged in!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kTextDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This is a placeholder — build your real home screen here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: kTextDark.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),
    );
  }
}