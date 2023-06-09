import 'package:flutter/material.dart';

import '../screens/completeSignUp/completeSignUp.dart';
import '../screens/homeScreen/homescreen.dart';
import '../screens/splashScreen/splashScreen.dart';
import '../sharedPreference/sharedPreference.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    super.initState();
    getState() async {
      var uid = sharedPrefence().getSignIn();
      var success = sharedPrefence().getVerification();
      if (success == 'succes') {
        if (uid == 'uid') {
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
              builder: (context) => const SplashScreen(),
            ),
            (route) => false);
        // startTimer();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
