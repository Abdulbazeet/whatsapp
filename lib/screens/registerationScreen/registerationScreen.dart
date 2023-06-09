import 'package:flutter/material.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../const/otp.dart';
import '../homeScreen/homescreen.dart';
import '../verificationScreen/verificationScreen.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});
  static String code = '';

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController countrycode = TextEditingController(text: '234');
  TextEditingController phonenumber = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    countrycode.dispose();
    phonenumber.dispose();
    super.dispose();
  }

  // void verifyOTP(String phoneNumber) async {
  //   await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: OTP.verificationCompleted,
  //       verificationFailed: OTP.verificationFailed,
  //       codeSent: OTP.codeSent,
  //       codeAutoRetrievalTimeout: OTP.codeAutoRetrievalTimeout);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 3.h),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Enter your phone number',
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'WhatsApp will ned to verify your account ',
                            style: TextStyle(fontSize: 8.sp),
                          ),
                          TextSpan(
                            text: "What's your number? ",
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: Colors.blue[200],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60.w,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1.5.toInt(),
                            child: TextField(
                              controller: countrycode,
                              textDirection: TextDirection.rtl,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(right: 12),
                                // constraints: BoxConstraints(maxWidth: ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF51795E),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF4CFA86),
                                  ),
                                ),
                                prefixText: '+',
                                prefixStyle: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Flexible(
                            flex: 3,
                            child: TextField(
                              textInputAction: TextInputAction.done,
                              maxLength: 10,
                              onChanged: (value) {
                                value = phonenumber.text;
                              },
                              keyboardType: TextInputType.number,
                              controller: phonenumber,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: 'phone number',
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Carrier charges may apply',
                      style: TextStyle(
                          fontSize: 8.sp,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: backgroundColor,
                          color: Colors.greenAccent[400],
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          backgroundColor: Colors.greenAccent[400],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontSize: 8.sp,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await _firebaseAuth.verifyPhoneNumber(
                                timeout: const Duration(seconds: 60),
                                phoneNumber: '+234${phonenumber.text}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await _firebaseAuth
                                      .signInWithCredential(credential);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (route) => false);
                                },
                                verificationFailed: (FirebaseAuthException e) {
                                  if (e.code == 'invalid-phone-number') {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    // print('The provided phone number is not valid.');
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: backgroundColor,
                                          title: const Center(
                                              child: Text(
                                            'Error',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          content: const Text(
                                            'The provided phone number is not valid.',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),

                                          // title: Text('Verification failed'),
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: backgroundColor,
                                          title: const Center(
                                              child: Text(
                                            'Error',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
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
                                  }
                                  // print('The provided phone number is not valid.');
                                },
                                codeSent: (String verificationId,
                                    int? resendToken) async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  RegisterationScreen.code = verificationId;

                                  String smsCode = '';

                                  // Create a PhoneAuthCredential with the code
                                  PhoneAuthCredential credential =
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: smsCode);
                                  // setState(() {
                                  //   isLoading = false;
                                  // });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            verificationScreen(
                                          phoneNumber:
                                              '+234${phonenumber.text}',
                                        ),
                                      ),
                                      (route) => false);
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {});
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: backgroundColor,
                                  title: const Center(child: Text('Error')),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  content: Text(
                                    e.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),

                                  // title: Text('Verification failed'),
                                );
                              },
                            );

                            // print(e);
                            // print('+234 ${phonenumber.text}');
                          }
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
