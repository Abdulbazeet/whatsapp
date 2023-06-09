import 'package:flutter/material.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isMessage = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isMessage
          ? null
          : ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: Image.asset('assets/contact.png').image,
                  backgroundColor: Colors.grey,
                ),
                title: Text(
                  'My name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontStyle: FontStyle.italic),
                ),
                subtitle: Text(
                  'message',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 8.sp,
                      color: Colors.white),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'data',
                      style: TextStyle(color: mainColor),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Text(
                      'data',
                      style: TextStyle(color: mainColor),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
