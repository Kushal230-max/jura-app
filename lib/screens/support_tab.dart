// lib/screens/support_tab.dart
import 'package:flutter/material.dart';

class SupportTab extends StatelessWidget {
  const SupportTab({super.key});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  static const List<_Faq> _faqs = [
    _Faq('How do I add an emergency contact?',
        'Go to Profile → Emergency contacts → tap the + icon to add a contact.'),
    _Faq('Does the app work without internet?',
        'Location sharing and alerts need a connection, but helpline numbers work offline.'),
    _Faq('Can I turn off location sharing?',
        'Yes, toggle it off anytime from Profile → Location sharing.'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const Text('Support',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextDark)),
          const SizedBox(height: 4),
          Text("We're here if you need us",
              style: TextStyle(fontSize: 13, color: kTextDark.withValues(alpha: 0.6))),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: Icons.chat_bubble_outline,
                  label: 'Live chat',
                  onTap: () => _snack(context, 'Opening live chat…'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionCard(
                  icon: Icons.mail_outline,
                  label: 'Email us',
                  onTap: () => _snack(context, 'Opening email…'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Frequently asked',
              style: TextStyle(fontWeight: FontWeight.bold, color: kTextDark)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                for (int i = 0; i < _faqs.length; i++) ...[
                  _FaqTile(faq: _faqs[i]),
                  if (i != _faqs.length - 1) const Divider(height: 1),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.label, required this.onTap});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: kPrimary, size: 26),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: kTextDark)),
          ],
        ),
      ),
    );
  }
}

class _Faq {
  final String question;
  final String answer;
  const _Faq(this.question, this.answer);
}

class _FaqTile extends StatelessWidget {
  final _Faq faq;
  const _FaqTile({required this.faq});

  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(faq.question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: kTextDark)),
      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      expandedAlignment: Alignment.topLeft,
      children: [
        Text(faq.answer, style: TextStyle(color: kTextDark.withValues(alpha: 0.7), fontSize: 13)),
      ],
    );
  }
}