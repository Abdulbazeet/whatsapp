import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sizer/sizer.dart';

import '../chatScreen/ChattingScreen/chattingScreen.dart';

Widget body(
    BuildContext context, bool _permissionDenied, List<Contact>? _contacts) {
  if (_permissionDenied) {
    return Center(
      child: Text(
        'Permission denied',
        style: TextStyle(color: Colors.white, fontSize: 8.sp),
      ),
    );
  }
  if (_contacts == null) {
    return const Center(child: CircularProgressIndicator());
  }
  return StreamBuilder(
    builder: (context, snapshot) => ListView.builder(
      itemCount: _contacts!.length,
      itemBuilder: (context, i) => ListTile(
        title: Text(_contacts![i].displayName),
        onTap: () async {
          final fullContact =
              await FlutterContacts.getContact(_contacts![i].id);
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChattingScreen(fullContact!),
            ),
          );
        },
      ),
    ),
  );
}
