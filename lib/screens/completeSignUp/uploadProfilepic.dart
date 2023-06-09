import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadPic(File file) async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final userUid = firebaseAuth.currentUser!.uid;
  Reference ref = firebaseStorage.ref().child(userUid).child('profileImage');
  // final storageRef = firebaseStorage.ref();
  if (file != null) {
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } else {
    String filePath = 'assets/contact.png';
    final path = File(filePath);
    UploadTask uploadTask = ref.putFile(path);
    TaskSnapshot taskSnapshot = await uploadTask;
    String download = await taskSnapshot.ref.getDownloadURL();
    return download;
  }
}
