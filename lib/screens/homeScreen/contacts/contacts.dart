import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';

import 'contactList.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ],
          backgroundColor: const Color.fromARGB(255, 22, 63, 59),
          title: ListTile(
            title: Text(
              'Select conatct',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontStyle: FontStyle.italic),
            ),
            subtitle: Text(
              '234 contacts',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 8.sp,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ),
        body: body(context, _permissionDenied, _contacts));
  }
}
