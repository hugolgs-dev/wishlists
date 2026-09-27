import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../async_ui.dart';
import '../client.dart';
import 'person_list_screen.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  late Future<List<Member>> _members = client.family.members();

  void _reload() => setState(() {
    _members = client.family.members();
  });

  @override
  Widget build(BuildContext context) {
    return AsyncList(
      future: _members,
      onRetry: _reload,
      emptyText: 'No one else has joined yet.',
      itemBuilder: (member) => ListTile(
        leading: CircleAvatar(
          child: Text(member.name.isEmpty ? '?' : member.name[0].toUpperCase()),
        ),
        title: Text(member.name),
        trailing: const Icon(Icons.chevron_right),
        // Push = open a new screen on top; the back button returns here.
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PersonListScreen(member: member)),
        ),
      ),
    );
  }
}
