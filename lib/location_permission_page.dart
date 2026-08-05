import 'package:flutter/material.dart';
import 'package:jura_app/home_page.dart';

class LocationPermissionPage extends StatelessWidget {
  const LocationPermissionPage({super.key});

  static const Color kBackground = Color(0xFFF9E1EC);
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  // Path to the illustration asset. Update this if you rename/move the file.
  static const String kIllustrationAsset =
      'assets/images/location_permission.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back, color: kTextDark),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 12),

              // Illustration card
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: _buildIllustration(),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Allow Location Access',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'To find nearby help and share your location\nduring emergencies.',
                style: TextStyle(
                  fontSize: 14,
                  color: kTextDark.withValues(alpha: 0.6),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              _buildChecklistItem('Share live location'),
              const SizedBox(height: 10),
              _buildChecklistItem('Find nearby help'),
              const SizedBox(height: 10),
              _buildChecklistItem('Faster emergency response'),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: const Text(
                    'Allow Access',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: kTextDark.withValues(alpha: 0.15)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  child: Text(
                    'Maybe Later',
                    style: TextStyle(
                      color: kTextDark.withValues(alpha: 0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the illustration, falling back to a placeholder icon if the
  /// asset hasn't been added to the project yet (so the app never crashes
  /// on a missing asset during development).
  Widget _buildIllustration() {
    return Image.asset(
      kIllustrationAsset,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.map_outlined,
            size: 100,
            color: kPrimary.withValues(alpha: 0.85),
          ),
        );
      },
    );
  }

  Widget _buildChecklistItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check, size: 18, color: kPrimary),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: kTextDark.withValues(alpha: 0.8)),
        ),
      ],
    );
  }
}