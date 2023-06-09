import 'dart:io';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:whatsapp/screens/completeSignUp/uploadProfilepic.dart';
import 'package:sizer/sizer.dart';

import '../../models/usermodel.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
Future signIn(BuildContext context, File chosenImage, String name) async {
  try {
    final user = firebaseAuth.currentUser;
    String? userId = user?.uid;
    String? userNumber = user?.phoneNumber;
    String picture = await uploadPic(chosenImage);
    // String picture =   MediaStorage().
    Users users = Users(
      name: name,
      userId: userId!,
      photoUrl: picture,
      bio: 'Enjoying whatsApp',
      phoneNumber: userNumber!,
    );
    firebaseFirestore.collection('users').doc(userId).set(
          users.toMap(),
        );
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: backgroundColor,
        title: const Center(
          child: Text(
            'Error',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        content: Text(e.toString()),
        contentTextStyle: TextStyle(
            color: Colors.white, fontStyle: FontStyle.italic, fontSize: 8.sp),
      ),
    );
    print(e);
  }
}
