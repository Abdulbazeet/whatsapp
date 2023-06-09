import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp/const/app_const.dart';
import 'package:whatsapp/screens/completeSignUp/completeSignUp.dart';
import 'package:whatsapp/screens/homeScreen/homescreen.dart';

import 'package:whatsapp/screens/splashScreen/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/screens/verificationScreen/verificationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/sharedPreference/sharedPreference.dart';

import 'const/otp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // setHomeScreen();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              backgroundColor: backgroundColor,
              // primaryColor: const Color(0xFF143820),

              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              // primarySwatch: Colors.blue,
            ),
            home: const SplashScreen()
            // StreamBuilder(
            //   stream: ,
            //   builder: (context, snapshot) {

            // },)
            //  FutureBuilder<String>(
            //   future: sharedPrefence().getVerification(),
            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       // While waiting for the future to complete, show a loading screen
            //       return const SplashScreen();
            //     } else if (snapshot.hasData && snapshot.data == 'success') {
            //       return FutureBuilder<String>(
            //         future: sharedPrefence().getSignIn(),
            //         builder: (BuildContext context,
            //             AsyncSnapshot<String> signInSnapshot) {
            //           if (signInSnapshot.connectionState ==
            //               ConnectionState.waiting) {
            //             // While waiting for the future to complete, show a loading screen
            //             return const SplashScreen();
            //           } else if (signInSnapshot.hasData &&
            //               signInSnapshot.data == 'uid') {
            //             return const HomeScreen();
            //           } else {
            //             return const CompleteSIGNuP();
            //           }
            //         },
            //       );
            //     } else {
            //       return const SplashScreen();
            //     }
            //   },

            //   // home: if (sharedPrefence().getVerification() == 'succes') {
            //   //     if (sharedPrefence().getSignIn() == 'uid') {
            //   //       return const HomeScreen();
            //   //     } else {
            //   //       return const CompleteSIGNuP();
            //   //     }
            //   //   } else {
            //   //     return const SplashScreen();
            //   //   }
            // ),
            );
      },
    );
  }
}

// void setHomeScreen() async {
//   Widget getScreen() {
//     if (sharedPrefence().getVerification() == 'succes') {
//       if (sharedPrefence().getSignIn() == 'uid') {
//         return const HomeScreen();
//       } else {
//         return const CompleteSIGNuP();
//       }
//     } else {
//       return const SplashScreen();
//     }
//   }
// }

// Future<String> getSucces() async {
//   final SharedPreferences sharedPreferences =;
//       await SharedPreferences.getInstance();
//   String? succes = sharedPreferences.getString('succes') ?? '';
//   return succes;
// }

// Future<String> getHome() async {
//   final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();
//   String? succes = sharedPreferences.getString('uid') ?? '';
//   return succes;
// }
