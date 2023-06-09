import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chats {
  final String message;
  final String uid;
  final String profilePic;
  final DateTime dateTime;
  final bool isGroup;
  final String messageId;
  Chats({
    required this.message,
    required this.uid,
    required this.profilePic,
    required this.dateTime,
    required this.isGroup,
    required this.messageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'uid': uid,
      'profilePic': profilePic,
      'dateTime': Timestamp.fromDate(dateTime),
      'isGroup': isGroup,
      'messageId': messageId,
    };
  }

  static Chats fromSnap(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    return Chats(
        message: snap[''],
        uid: snap[''],
        profilePic: snap[''],
        dateTime: snap['dateTime'],
        isGroup: snap['']?? false,
        messageId: snap['']);
  }

  // String toJson() => json.encode(toMap());

  // factory Chats.fromJson(String source) => Chats.fromMap(json.decode(source) as Map<String, dynamic>);
}
