import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

class ChattingScreen extends StatefulWidget {
  final Contact? fullContacts;
  const ChattingScreen(Contact contact, {super.key, this.fullContacts});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
