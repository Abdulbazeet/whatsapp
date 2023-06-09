import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Users {
  late String name;
  late String userId;
  late String photoUrl;
  late String bio;
  late String phoneNumber;
  // late bool isOnline;
  Users({
    required this.name,
    required this.userId,
    required this.photoUrl,
    required this.bio,
    required this.phoneNumber,
    // required this.isOnline,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'photoUrl': photoUrl,
      'bio': bio,
      'phoneNumber': phoneNumber
    };
  }

  static Users fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Users(
      name: data['name'],
      userId: data['userId'],
      photoUrl: data['photoUrl'],
      bio: data['bio'],
      phoneNumber: data['phoneNumber'], 
      // isOnline: data['isOnline'] ?? false,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory Users.fromJson(String source) => Users.fromMap(json.decode(source) as Map<String, dynamic>);
}
