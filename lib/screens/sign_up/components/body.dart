import 'package:flutter/material.dart';

import '../../../components/buttons/rounded_button.dart';
import '../../../components/widgets/already_have_account.dart';
import '../../../components/text_fields/password_text_field.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../log_in/components/background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // todo check constraints
    return Background(
        body: Center(
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.05),
                    RoundedTextField(
                        onChanged: (String value) {},
                        hintText: 'Логин',
                        icon: Icons.person_outline_rounded),
                    RoundedTextField(
                        onChanged: (String value) {},
                        hintText: 'Почта',
                        icon: Icons.email_outlined),
                    const PasswordTextField(),
                    RoundedButton(text: 'Зарегистрироваться', press: () { }),
                    SizedBox(height: size.height * 0.05),
                    const AlreadyHaveAnAccountCheck(login: false),
                  ],
                ))));
  }
}
