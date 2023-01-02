import 'package:flutter/material.dart';
import 'package:shelfie/components/widgets/password_text_field.dart';
import '../constants.dart';

class PasswordState extends State<PasswordTextField> {
  bool _showEye = false;
  bool _passwordEncrypted = true;
  String _password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor)),
      child: TextField(
        cursorColor: primaryColor,
        style: const TextStyle(fontSize: 19),
        decoration: InputDecoration(
          hintText: 'Пароль',
          hintStyle: const TextStyle(color: grayColor, fontSize: 20),
          border: InputBorder.none,
          icon: const Icon(
            Icons.lock_outline_rounded,
            color: grayColor,
          ),
          suffixIcon: _showEye
              ? GestureDetector(
                  child: Container(
                    width: 25,
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: _passwordEncrypted
                        ? const Icon(
                            Icons.visibility_rounded,
                            color: grayColor,
                          )
                        : const Icon(
                            Icons.visibility_off_rounded,
                            color: grayColor,
                          ),
                  ),
                  onTap: () {
                    setState(() {
                      _passwordEncrypted = !_passwordEncrypted;
                    });
                  },
                )
              : null,
        ),
        obscureText: _showEye ? _passwordEncrypted : true,
        obscuringCharacter: '●',
        onChanged: (enteredPassword) {
          _password = enteredPassword;
          if (enteredPassword.isEmpty) {
            setState(() {
              _showEye = false;
            });
          } else {
            if (!_showEye) {
              setState(() {
                _showEye = !_showEye;
              });
            }
          }
        },
      ),
    );
  }
}
