// import 'package:contacts_service/contacts_service.dart';
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
  getContacts() async {
    final name = await FlutterContacts.getContacts(
        withPhoto: true, withProperties: true);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            '${_contacts!.length} contacts',
            style: TextStyle(
                color: Colors.white,
                fontSize: 8.sp,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) => ListView.builder(
          itemCount: _contacts!.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_contacts![index].displayName),
          ),
        ),
      ),
    );
  }
}
