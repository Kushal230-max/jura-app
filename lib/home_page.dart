import 'package:flutter/material.dart';
import 'screens/sos_home_tab.dart';
import 'screens/profile_tab.dart';
import 'widgets/placeholder_tab.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color kBackground = Color(0xFFF9E1EC);
  static const Color kPrimary = Color(0xFFE6297A);

  int _currentIndex = 0;

  static const List<Widget> _tabs = [
    SosHomeTab(),
    PlaceholderTab(
      icon: Icons.phone_in_talk_outlined,
      title: 'Helplines',
      subtitle: 'Quick-dial emergency helplines will show up here.',
    ),
    PlaceholderTab(
      icon: Icons.map_outlined,
      title: 'Nearby',
      subtitle: 'Nearby help, shelters, and services will show up here.',
    ),
    PlaceholderTab(
      icon: Icons.support_agent_outlined,
      title: 'Support',
      subtitle: 'Chat and support resources will show up here.',
    ),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _currentIndex, children: _tabs),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.phone_outlined), label: 'Helplines'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), label: 'Nearby'),
          BottomNavigationBarItem(icon: Icon(Icons.headset_mic_outlined), label: 'Support'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}