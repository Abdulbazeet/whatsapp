import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../completeSignUp/completeSignUp.dart';
import '../homeScreen/homescreen.dart';
import '../registerationScreen/registerationScreen.dart';

class verificationScreen extends StatefulWidget {
  final String phoneNumber;
  const verificationScreen({super.key, required this.phoneNumber});
  static var newCode = '';

  @override
  State<verificationScreen> createState() => _verificationScreenState();
}

class _verificationScreenState extends State<verificationScreen> {
  TextEditingController otp = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isWaiting = false;
  var oneSec = const Duration(seconds: 1);
  var startValue = 60;
  wait() async {
    setState(() {
      isWaiting = true;
    });

    Timer timer = Timer.periodic(
      oneSec,
      (timer) {
        setState(() {
          if (startValue == 0) {
            startValue = 60;
            isWaiting = false;
            timer.cancel();
          } else {
            startValue--;
          }
        });
      },
    );
    // setState(() {
    //   if (startValue == 0) {
    //     startValue == 60;
    //     isWaiting = false;
    //     Timer timer = Timer.periodic(oneSec, (timer) {});
    //     timer.cancel();
    //   } else {
    //     startValue--;
    //   }
    // });
  }

  @override
  void initState() {
    wait();
    super.initState();
  }

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }

  void registerNumber() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            )
          : SafeArea(
              child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    'Verifying your number',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 9.sp),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                'Waiting automatically detect as SMS sent to ${widget.phoneNumber}. ',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 8.sp)),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterationScreen(),
                                  ),
                                  (route) => false);
                            },
                          text: 'Wrong Number?',
                          style: TextStyle(
                            color: Colors.blue[300],
                            fontSize: 8.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: 30.w,
                    child: TextField(
                      onSubmitted: (value) async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: RegisterationScreen.code,
                                  smsCode: otp.text);

                          await _firebaseAuth.signInWithCredential(credential);
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const CompleteSIGNuP(),
                              ),
                              (route) => false);
                        } catch (e) {
                          print(e);
                        }
                      },
                      maxLength: 6,
                      onChanged: (value) {
                        value = otp.text;
                      },
                      // onEditingComplete: () async {
                      //   // String smsCode = '';

                      //   // Create a PhoneAuthCredential with the code
                      // },
                      // textAlign: TextAlign.center,
                      // textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      controller: otp,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: '',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 8.sp,
                            fontStyle: FontStyle.italic),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF51795E),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4CFA86),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    'Enter 6-digit code',
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontStyle: FontStyle.italic,
                        fontSize: 8.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Didn't receive code?",
                    style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 8.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  isWaiting
                      ? Text(
                          "You may request a new code in ${startValue.toString()}",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 8.sp,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() async {
                              try {
                                await _firebaseAuth.verifyPhoneNumber(
                                    timeout: const Duration(seconds: 60),
                                    phoneNumber: widget.phoneNumber,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) async {
                                      await _firebaseAuth
                                          .signInWithCredential(credential);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeScreen()),
                                          (route) => false);
                                    },
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: backgroundColor,
                                            title: const Center(
                                                child: Text('Error')),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            content: Text(
                                              e.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                          // title: Text('Verification failed'),
                                        },
                                      );
                                    },
                                    // print('The provided phone number is not valid.');

                                    codeSent: (String verificationId,
                                        int? resendToken) async {
                                      RegisterationScreen.code = verificationId;

                                      String smsCode = otp.text;

                                      // Create a PhoneAuthCredential with the code
                                      PhoneAuthCredential credential =
                                          PhoneAuthProvider.credential(
                                              verificationId: verificationId,
                                              smsCode: smsCode);

                                      await _firebaseAuth
                                          .signInWithCredential(credential);
                                      @override
                                      void dispose() {
                                        otp.dispose();
                                        super.dispose();
                                      }
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {});
                                wait();
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: backgroundColor,
                                      title: const Center(
                                        child: Text('Error'),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      content: Text(
                                        e.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),

                                      // title: Text('Verification failed'),
                                    );
                                  },
                                );

                                // print(e);
                                // print('+234 ${phonenumber.text}');
                              }
                              // wait();
                            });
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: Colors.blue[300],
                              fontSize: 8.sp,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                ],
              ),
            )),
    );
  }
}
