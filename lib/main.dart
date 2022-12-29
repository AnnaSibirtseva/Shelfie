import 'package:flutter/material.dart';
import 'package:shelfie/screens/log_in/log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shelfie',
      theme: ThemeData(
        fontFamily: 'VelaSans',
        primaryColor: Colors.indigo.shade600,
      ),
      home: const LogInPage(),
    );
  }
}
