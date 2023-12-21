import 'package:flutter/material.dart';
import 'package:shelfie/screens/home/home_page.dart';
import 'package:shelfie/screens/log_in/log_in_page.dart';
import '../../components/secure_storage/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

final StorageService storageService = StorageService();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _startApp();
    super.initState();
  }

  Future<void> _startApp() async {
    int? _id = (await storageService.readSecureData("id")) as int?;
    if (_id != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LogInPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(_id!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splashscreen"),
      ),
    );
  }
}
