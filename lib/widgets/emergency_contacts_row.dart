import 'package:flutter/material.dart';
import '../models/emergency_contact.dart';


class EmergencyContactsRow extends StatelessWidget {
  final double avatarRadius;

  const EmergencyContactsRow({super.key, this.avatarRadius = 22});

  static const Color kPrimary = Color(0xFFE6297A);
  static const Color kTextDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ContactsStore.instance,
      builder: (context, _) {
        final contacts = ContactsStore.instance.contacts;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final contact in contacts)
              GestureDetector(
                onTap: () => _showEditDeleteSheet(context, contact),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: contact.avatarColor,
                  child: Text(
                    contact.initials,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: avatarRadius * 0.7,
                    ),
                  ),
                ),
              ),
            InkWell(
              borderRadius: BorderRadius.circular(avatarRadius),
              onTap: () => _showAddDialog(context),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: kPrimary.withValues(alpha: 0.12),
                child: Icon(Icons.add, color: kPrimary, size: avatarRadius),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add emergency contact'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Contact name'),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: kPrimary),
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (name != null && name.trim().isNotEmpty) {
      ContactsStore.instance.addContact(name);
    }
  }

  Future<void> _showEditDeleteSheet(
      BuildContext context, EmergencyContact contact) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: contact.avatarColor,
                      child: Text(
                        contact.initials,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kTextDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: kPrimary),
                title: const Text('Rename'),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _showEditDialog(context, contact);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _confirmDelete(context, contact);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showEditDialog(
      BuildContext context, EmergencyContact contact) async {
    final controller = TextEditingController(text: contact.name);
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Rename contact'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: kPrimary),
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (name != null && name.trim().isNotEmpty) {
      ContactsStore.instance.updateContact(contact.id, name);
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, EmergencyContact contact) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove contact?'),
        content: Text('Remove ${contact.name} from your emergency contacts?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      ContactsStore.instance.deleteContact(contact.id);
    }
  }
}