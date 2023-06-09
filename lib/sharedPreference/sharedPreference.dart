import 'package:shared_preferences/shared_preferences.dart';

class sharedPrefence {
  Future onVerification() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var shared = await sharedPreferences.setString('succes', 'success');
    return shared;
  }

  Future onSignIn(String uid) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();

    var userUid = await shared.setString('uid', uid);
    return userUid;
  }

  Future getVerification() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? onVerify = sharedPreferences.getString('succes');

    return onVerify;
  }

  Future getSignIn() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? onSignIn = shared.getString('uid');
    return onSignIn;
  }
}
