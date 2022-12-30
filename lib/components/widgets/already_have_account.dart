import 'package:flutter/material.dart';

import '../../screens/log_in/log_in_page.dart';

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
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black38),
        ),
        GestureDetector(
          onTap: !login ? () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInPage())) :
              () => {},
          child: Text(
            login ? "ЗАРЕГИСТРИРОВАТЬСЯ" : "ВОЙТИ",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}