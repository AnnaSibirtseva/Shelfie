import 'package:flutter/material.dart';

import '../../screens/log_in/log_in_page.dart';
import '../../screens/sign_up/sign_up_page.dart';
import '../constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;

  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Нет аккаунта? " : "Уже есть аккаунт? ",
          style: const TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.w600, color: grayColor),
        ),
        GestureDetector(
          onTap: !login
              ? () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LogInPage()))
              : () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage())),
          child: Text(
            login ? "ЗАРЕГИСТРИРОВАТЬСЯ" : "ВОЙТИ",
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
