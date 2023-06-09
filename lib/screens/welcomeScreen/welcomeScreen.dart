import 'package:flutter/material.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:sizer/sizer.dart';

import '../registerationScreen/registerationScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              CircleAvatar(
                radius: 20.h,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  'assets/bg.png',
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'Welcome to whatsapp',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 2.h,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 8.sp),
                  children: [
                    const TextSpan(
                      text: 'Read our',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: ' Privacy Policy.',
                      style: TextStyle(
                        color: Colors.blue[300],
                      ),
                    ),
                    const TextSpan(
                      text: ' Tap "Agree and continue" to accept the ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: Colors.blue[300],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                onPressed: () {
                  print('object');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterationScreen()));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.w),
                    ),
                    backgroundColor: Colors.greenAccent[400]),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
                  child: Text(
                    'Agree and continue',
                    style: TextStyle(color: Colors.black, fontSize: 8.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
