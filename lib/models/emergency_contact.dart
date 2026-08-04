import 'package:flutter/material.dart';

/// A single emergency contact. Mutable copy via [copyWith] so the store
/// can update a contact's name without losing its id/color.
class EmergencyContact {
  final String id;
  final String name;
  final Color avatarColor;

  const EmergencyContact({
    required this.id,
    required this.name,
    required this.avatarColor,
  });

  String get initials => name.trim().isEmpty
      ? '?'
      : name.trim().substring(0, 1).toUpperCase();

  EmergencyContact copyWith({String? name, Color? avatarColor}) {
    return EmergencyContact(
      id: id,
      name: name ?? this.name,
      avatarColor: avatarColor ?? this.avatarColor,
    );
  }
}


class ContactsStore extends ChangeNotifier {
  ContactsStore._internal();
  static final ContactsStore instance = ContactsStore._internal();

  static const List<Color> _palette = [
    Color(0xFFE29BC0),
    Color(0xFFEFC28C),
    Color(0xFFB6A5E8),
    Color(0xFF8CC7EF),
    Color(0xFF9BE2B8),
  ];

  int _nextColor = 0;

  final List<EmergencyContact> _contacts = [
    EmergencyContact(id: 'c0', name: 'Aarati', avatarColor: _palette[0]),
    EmergencyContact(id: 'c1', name: 'Sita', avatarColor: _palette[1]),
    EmergencyContact(id: 'c2', name: 'Rita', avatarColor: _palette[2]),
  ];

  List<EmergencyContact> get contacts => List.unmodifiable(_contacts);

  void addContact(String name) {
    if (name.trim().isEmpty) return;
    final color = _palette[_nextColor % _palette.length];
    _nextColor++;
    final id = 'c-${DateTime.now().microsecondsSinceEpoch}';
    _contacts.add(EmergencyContact(id: id, name: name.trim(), avatarColor: color));
    notifyListeners();
  }

  void updateContact(String id, String newName) {
    if (newName.trim().isEmpty) return;
    final index = _contacts.indexWhere((c) => c.id == id);
    if (index == -1) return;
    _contacts[index] = _contacts[index].copyWith(name: newName.trim());
    notifyListeners();
  }

  void deleteContact(String id) {
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}