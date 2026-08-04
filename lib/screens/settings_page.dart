import 'package:flutter/material.dart';
import 'onboarding_redirect.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  bool _notifications = true;
  bool _locationAccess = true;
  bool _shareAnalytics = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: kTextDark,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: kTextDark),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          _sectionHeader('General'),
          _switchTile(
            icon: Icons.notifications_none,
            label: 'Notification',
            value: _notifications,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          _switchTile(
            icon: Icons.location_on_outlined,
            label: 'Location access',
            value: _locationAccess,
            onChanged: (v) => setState(() => _locationAccess = v),
          ),
          _switchTile(
            icon: Icons.bar_chart,
            label: 'Share Analytics',
            value: _shareAnalytics,
            onChanged: (v) => setState(() => _shareAnalytics = v),
          ),
          const SizedBox(height: 16),
          _sectionHeader('Account'),
          _navTile(
            icon: Icons.privacy_tip_outlined,
            label: 'Privacy Policy',
            onTap: () {},
          ),
          _navTile(
            icon: Icons.description_outlined,
            label: 'Terms & Conditions',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _sectionHeader('More'),
          _navTile(
            icon: Icons.star_border,
            label: 'Rate us',
            onTap: () {},
          ),
          _navTile(
            icon: Icons.logout,
            label: 'Logout',
            labelColor: kPrimary,
            iconColor: kPrimary,
            onTap: () => confirmAndLogout(context),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: kTextDark.withValues(alpha: 0.85),
          ),
        ),
      );

  Widget _switchTile({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: kTextDark.withValues(alpha: 0.7)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 15))),
          Switch(value: value, activeThumbColor: kPrimary, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _navTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? labelColor,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? kTextDark.withValues(alpha: 0.7)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 15, color: labelColor ?? kTextDark),
              ),
            ),
            Icon(Icons.chevron_right,
                size: 20, color: kTextDark.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}