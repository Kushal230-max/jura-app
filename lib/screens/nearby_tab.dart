// lib/screens/nearby_tab.dart
import 'package:flutter/material.dart';

class NearbyTab extends StatelessWidget {
  const NearbyTab({super.key});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  static const List<_Place> _places = [
    _Place('Metro Police Station', 'Police', '0.6 km', Icons.local_police_outlined),
    _Place('City Hospital', 'Hospital', '1.2 km', Icons.local_hospital_outlined),
    _Place("Women's Safe Shelter", 'Shelter', '2.1 km', Icons.home_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          const Text(
            'Nearby help',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kTextDark),
          ),
          const SizedBox(height: 4),
          Text(
            'Based on your last known location',
            style: TextStyle(fontSize: 13, color: kTextDark.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 16),

          // Static map placeholder — swap for a real map widget later if needed
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: kPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.map_outlined, size: 56, color: kPrimary.withValues(alpha: 0.5)),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.my_location, size: 14, color: kPrimary),
                        const SizedBox(width: 4),
                        Text('You',
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600, color: kTextDark)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          for (final p in _places) _PlaceCard(place: p),
        ],
      ),
    );
  }
}

class _Place {
  final String name;
  final String category;
  final String distance;
  final IconData icon;
  const _Place(this.name, this.category, this.distance, this.icon);
}

class _PlaceCard extends StatelessWidget {
  final _Place place;
  const _PlaceCard({required this.place});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: kPrimary.withValues(alpha: 0.12),
            child: Icon(place.icon, color: kPrimary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: kTextDark)),
                Text('${place.category} · ${place.distance}',
                    style: TextStyle(color: kTextDark.withValues(alpha: 0.6), fontSize: 13)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening directions to ${place.name}…')),
              );
            
            },
            child: const Text('Directions',
                style: TextStyle(color: kPrimary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}