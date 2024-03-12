import 'package:flutter/material.dart';
import 'components/constants.dart';
import 'components/routes/route.gr.dart';
import 'package:flutter/services.dart';

final _appRouter = AppRouter();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
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
