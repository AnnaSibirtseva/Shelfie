import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../components/routes/route.gr.dart';
import '../../screens/log_in/log_in_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  Future<void> _startApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = preferences.getInt('userId');
    if (id == null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInPage())));
    } else {
      Timer(Duration(seconds: 3),
          () => context.router.push(HomeRoute(userId: id)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/magic-book.gif',
            height: 125.0,
            width: 125.0,
          ),
          const SizedBox(height: 10),
          const Text(
            'SHELFIE',
            style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.w900, color: blackColor),
          ),
        ],
      ),
    ));
  }
}
