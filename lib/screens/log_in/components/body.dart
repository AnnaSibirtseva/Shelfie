import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../components/buttons/rounded_button.dart';
import '../../../components/constants.dart';
import '../../../models/user.dart';
import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/already_have_account.dart';
import '../../../components/text_fields/password_text_field.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _email;
  final PasswordTextField passwordField = PasswordTextField();

  Future<int> loginUser() async {
    var client = http.Client();
    final jsonString = json.encode({
      "email": _email,
      "password": passwordField.getPassword(),
    });
    try {
      var response = await client.post(Uri.https(url, '/users/user/login'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode == 200) {
        return User.userIdFromJson(jsonDecode(utf8.decode(response.bodyBytes)))
            .getId();
      } else {
        throw Exception('Не удалось зайти в приложение');
      }
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        body: Center(
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05),
                    RoundedTextField(
                        onChanged: (String value) {
                          _email = value;
                        },
                        hintText: 'Почта',
                        icon: Icons.email_outlined),
                    passwordField,
                    RoundedButton(
                        text: 'Войти',
                        press: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if (_email.trim().isEmpty ||
                              passwordField.getPassword().trim().isEmpty) {
                            Flushbar(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(15),
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: redColor,
                              messageText: const Text(
                                "Поля почты и пароля являются обязательными для заполнения",
                                style: TextStyle(
                                    fontSize: 14.0, color: whiteColor, fontWeight: FontWeight.w500),
                              ),
                              icon: const Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: whiteColor,
                              ),
                              duration: const Duration(seconds: 5),
                            ).show(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                margin: const EdgeInsets.all(5),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: const Duration(seconds: 30),
                                backgroundColor: primaryColor,
                                content: const Text(
                                    "Выполняется вход в аккаунт...")));
                            try {
                              int id = await loginUser();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setInt('userId', id);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              context.router.push(HomeRoute(userId: id));
                            } on Exception catch (_) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const NothingFoundDialog(
                                        'Ошибка входа!\nПроверьте корректность почты и пароля',
                                        warningGif,
                                        'Ошибка');
                                  });
                            }
                          }
                        }),
                    SizedBox(height: size.height * 0.05),
                    const AlreadyHaveAnAccountCheck(),
                  ],
                ))));
  }
}
