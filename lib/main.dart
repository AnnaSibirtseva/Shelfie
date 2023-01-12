import 'package:flutter/material.dart';
import 'package:shelfie/screens/log_in/log_in_page.dart';

import 'components/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'components/routes/route.gr.dart';

final _appRouter = AppRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shelfie',
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
        fontFamily: 'VelaSans',
        primaryColor: primaryColor,
      ),
      builder: (context, router) => router!,
    );
  }
}
