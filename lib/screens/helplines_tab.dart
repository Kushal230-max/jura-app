// lib/screens/helplines_tab.dart
import 'package:flutter/material.dart';

class HelplinesTab extends StatelessWidget {
  const HelplinesTab({super.key});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  static const List<_Helpline> _helplines = [
    _Helpline('Police', '100', Icons.shield_outlined),
    _Helpline('Ambulance', '102', Icons.local_hospital_outlined),
    _Helpline('Fire service', '101', Icons.local_fire_department_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const Text(
            'Helplines',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextDark),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap to call. Numbers shown are for reference.',
            style: TextStyle(fontSize: 13, color: kTextDark.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 16),
          for (final h in _helplines) _HelplineCard(helpline: h),
        ],
      ),
    );
  }
}

class _Helpline {
  final String title;
  final String number;
  final IconData icon;
  const _Helpline(this.title, this.number, this.icon);
}

class _HelplineCard extends StatelessWidget {
  final _Helpline helpline;
  const _HelplineCard({required this.helpline});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: kPrimary.withValues(alpha: 0.12),
            child: Icon(helpline.icon, color: kPrimary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(helpline.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: kTextDark)),
                Text(helpline.number,
                    style: TextStyle(color: kTextDark.withValues(alpha: 0.6), fontSize: 13)),
              ],
            ),
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: kPrimary.withValues(alpha: 0.12),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.call, size: 18, color: kPrimary),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Calling ${helpline.title} (${helpline.number})…')),
                );
               
              },
            ),
          ),
        ],
      ),
    );
  }
}