import 'package:flutter/material.dart';

import '../../../components/buttons/rounded_button.dart';
import '../../../components/constants.dart';
import '../../../components/image_constants.dart';
import '../../../components/routes/route.gr.dart';
import '../../../components/widgets/already_have_account.dart';
import '../../../components/text_fields/password_text_field.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../../components/widgets/dialogs/nothing_found_dialog.dart';
import '../../../controllers/user_controller/user_controller.dart';
import 'package:auto_route/auto_route.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late String _email;
  final PasswordTextField passwordField = PasswordTextField();

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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: primaryColor,
                                  content:
                                      Text("Выполняется вход в аккаунт...")));
                          try {
                            int id = await UserController.postUserLogin(
                                _email, passwordField.getPassword());
                            context.router.push(HomeRoute(userId: id));
                          } on Exception catch (_) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const NothingFoundDialog(
                                      'Ошибка входа!\nПроверьте корректность почты и пароля',
                                      warningGif,
                                      'Ошибка');
                                });
                          }
                        }),
                    SizedBox(height: size.height * 0.05),
                    const AlreadyHaveAnAccountCheck(),
                  ],
                ))));
  }
}
