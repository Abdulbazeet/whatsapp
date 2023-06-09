import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:whatsapp/screens/completeSignUp/signIn.dart';
import 'package:whatsapp/screens/completeSignUp/uploadProfilepic.dart';
import 'package:whatsapp/screens/homeScreen/homescreen.dart';

import '../../models/usermodel.dart';
import '../../sharedPreference/sharedPreference.dart';

class CompleteSIGNuP extends StatefulWidget {
  const CompleteSIGNuP({super.key});

  @override
  State<CompleteSIGNuP> createState() => _CompleteSIGNuPState();
}

class _CompleteSIGNuPState extends State<CompleteSIGNuP> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  File? chosenImage;
  Uint8List? images;
  String name = '';
  bool isloading = false;
  @override
  void initState() {
    sharedPrefence().onVerification();
    print(sharedPrefence().onVerification());
    super.initState();
  }

  final ImagePicker imagePicker = ImagePicker();
  void showBottomSheetDialog() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      backgroundColor: backgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      takePicture();
                    },
                    icon: const Icon(Icons.camera),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Camera',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      selectImage();
                    },
                    icon: const Icon(Icons.photo_size_select_actual_rounded),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontStyle: FontStyle.italic),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future takePicture() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final file = File(image.path);

      final imageChosen =
          await FlutterImageCompress.compressWithFile(file.path, quality: 95);
      setState(() {
        // chosenImage = image;
        // final imageFile = File(chosenImage!.path);
        images = imageChosen!;
      });
    }

    print('object');
  }

  Future selectImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      // final imageChosen =
      //     await FlutterImageCompress.compressWithFile(quality: 95, file.path);

      // chosenImage = image;
      // final imageFile = File(chosenImage!.path);
      setState(() {
        chosenImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Profile info',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Please provide your name and an optional profile photo',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 8.sp,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            showBottomSheetDialog();
                          },
                          child: chosenImage != null
                              ? CircleAvatar(
                                  radius: 12.w,
                                  backgroundImage:
                                      Image.file(chosenImage!).image,
                                )
                              : CircleAvatar(
                                  radius: 12.w,
                                  backgroundColor:
                                      const Color.fromARGB(255, 46, 42, 42),
                                  child: Stack(
                                    children: [
                                      Align(
                                        child: Icon(Icons.camera_alt_rounded,
                                            size: 12.w),
                                      ),
                                      Align(
                                          alignment: const Alignment(-.52, -.5),
                                          child: Icon(
                                            Icons.add,
                                            size: 3.h,
                                          ))
                                    ],
                                  ),
                                ),
                        ),
                        TextField(
                          onChanged: (value) async {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Type your name here',
                              hintStyle: TextStyle(
                                  fontSize: 8.sp,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey)),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Colors.greenAccent[400],
                                  backgroundColor: backgroundColor),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  backgroundColor: Colors.greenAccent[400]),
                              onPressed: () async {
                                if (name.isNotEmpty) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  signIn(context, chosenImage!, name);
                                  setState(() {
                                    isloading = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen(),
                                      ),
                                      (route) => false);
                                } else {
                                  final snackBar = SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: backgroundColor,
                                    content: Text(
                                      "Name can't be empty",
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                              )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
