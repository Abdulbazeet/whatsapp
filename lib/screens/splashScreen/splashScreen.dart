import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp/screens/homeScreen/homescreen.dart';
import 'package:whatsapp/screens/registerationScreen/registerationScreen.dart';
import 'package:whatsapp/screens/welcomeScreen/welcomeScreen.dart';
import '../../const/app_const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../sharedPreference/sharedPreference.dart';
import '../completeSignUp/completeSignUp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double iconStartSize = 8.h;
  double iconStopSize = 0;
  double time = 3.5;
  late SharedPreferences sharedPreferences;

  String? uidi;
  getIt() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final user = firebaseAuth.currentUser;
    if (user != null) {
      String uid = user.uid;
      setState(() {
        uidi = uid;
      });
    } else {
      setState(() {
        uidi = null;
      });
    }
  }

  @override
  void initState() {
    // getState();
    getIt();

    super.initState();

    startTimer();
  }

  void startTimer() {
    Timer(
      const Duration(seconds: 4),
      () async {
        var id = await sharedPrefence().getSignIn();
        var success = await sharedPrefence().getVerification();
        if (success == 'success') {
          if (id == uidi) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const CompleteSIGNuP(),
                ),
                (route) => false);
          }
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
              (route) => false);
          // startTimer();
        }
        print(success);
      },
    );
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 45.h,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/whatsapp-svgrepo-com.svg',
              height: iconStartSize,
              width: iconStartSize,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 35.h,
          ),
          Center(
            child: Column(
              children: [
                const Text(
                  'from',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/meta-logo-facebook-svgrepo-com.svg',
                        color: Colors.white,
                        height: 3.h,
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        'Meta',
                        style: GoogleFonts.mulish(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }
}
