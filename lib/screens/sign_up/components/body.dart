import 'dart:io';

import 'package:flutter/material.dart';

import '../../../components/buttons/rounded_button.dart';
import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/already_have_account.dart';
import '../../../components/text_fields/password_text_field.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../models/user.dart';
import 'package:auto_route/auto_route.dart';
import '../../log_in/components/background.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _email = '';
  late String _name = '';
  final PasswordTextField passwordField = PasswordTextField();

  Future<void> addUser() async {
    var client = http.Client();
    final jsonString = json.encode({
      "email": _email,
      "password": passwordField.getPassword(),
      "name": _name
    });
    try {
      var response = await client.post(Uri.https(url, '/users/user/add'),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
          body: jsonString);
      if (response.statusCode != 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const NothingFoundDialog(
                  'Что-то пошло не так! Не удалось зарегестрировать пользователя.',
                  warningGif,
                  'Ошибка');
            });
      }
    } finally {
      client.close();
    }
  }

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
                          _name = value;
                        },
                        hintText: 'Логин',
                        icon: Icons.person_outline_rounded),
                    RoundedTextField(
                        onChanged: (String value) {
                          _email = value;
                        },
                        hintText: 'Почта',
                        icon: Icons.email_outlined),
                    passwordField,
                    RoundedButton(
                        text: 'Зарегистрироваться',
                        press: () async {
                          if (checkConstraints()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: primaryColor,
                                    content:
                                    Text("Выполняется регистрация аккаунта...")));
                            await addUser();
                            int id = await loginUser();
                            context.router.push(HomeRoute(userId: id));
                          }
                          //context.router.pop(true);
                        }),
                    SizedBox(height: size.height * 0.05),
                    const AlreadyHaveAnAccountCheck(login: false),
                  ],
                ))));
  }

  bool checkConstraints() {
    if (_name.length < minName || _name.length > maxName) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Имя должно содержать от 2 до 30 символов")));
      return false;
    }
    if (_email.length < minMail || _email.length > maxMail) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Почта должна содержать от 7 до 100 символов")));
      return false;
    }
    if (passwordField.getPassword().length < minPassword ||
        passwordField.getPassword().length > maxPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: redColor,
          content: Text("Пароль должно состоять из 8-30 символов")));
      return false;
    }
    return true;
  }
}
