import 'package:flutter/material.dart';
import 'package:shelfie/components/routes/route.gr.dart';

import '../../../components/buttons/rounded_button.dart';
import '../../../components/widgets/already_have_account.dart';
import '../../../components/text_fields/password_text_field.dart';
import '../../../components/text_fields/rounded_text_field.dart';
import '../../home/home_page.dart';
import 'package:auto_route/auto_route.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
                        onChanged: (String value) {},
                        hintText: 'Почта',
                        icon: Icons.email_outlined),
                    const PasswordTextField(),
                    RoundedButton(
                        text: 'Войти',
                        press: () => context.router.pushNamed('/home/')),
                    SizedBox(height: size.height * 0.05),
                    const AlreadyHaveAnAccountCheck(),
                  ],
                ))));
  }
}
