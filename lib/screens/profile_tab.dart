import 'package:flutter/material.dart';
import '../widgets/emergency_contacts_row.dart';
import 'settings_page.dart';
import 'onboarding_redirect.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  bool _locationSharing = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 26,
                backgroundColor: kPrimary,
                child: Icon(Icons.person, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              const Text(
                'user',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kTextDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency contacts',
                  style: TextStyle(
                    fontSize: 13,
                    color: kTextDark.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 12),
                const EmergencyContactsRow(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _card(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeThumbColor: kPrimary,
              value: _locationSharing,
              onChanged: (v) => setState(() => _locationSharing = v),
              secondary: const Icon(Icons.location_on_outlined, color: kPrimary),
              title: const Text('Location sharing'),
              subtitle: Text(_locationSharing ? 'On' : 'Off'),
            ),
          ),
          const SizedBox(height: 10),
          _card(
            child: Column(
              children: [
                _tile(
                  icon: Icons.settings_outlined,
                  label: 'App setting',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                ),
                const Divider(height: 1),
                _tile(
                  icon: Icons.help_outline,
                  label: 'Help & FAQ',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _tile(
                  icon: Icons.info_outline,
                  label: 'About us',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _tile(
                  icon: Icons.logout,
                  label: 'Logout',
                  iconColor: kPrimary,
                  labelColor: kPrimary,
                  onTap: () => confirmAndLogout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      );

  Widget _tile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
    Color? labelColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? kPrimary),
      title: Text(label, style: TextStyle(color: labelColor ?? kTextDark)),
      trailing: Icon(Icons.chevron_right, color: kTextDark.withValues(alpha: 0.4)),
      onTap: onTap,
    );
  }
}