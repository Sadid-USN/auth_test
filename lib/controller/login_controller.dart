import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController extends ChangeNotifier {
  var isLogin = false;

  bool passwordVisible = false;

  final phoneTextController = TextEditingController(text: "");
  final passwordTextController = TextEditingController(text: "");

  // void logOut() {
  //   _authManager.logOut();
  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
  // }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйса введите почту';
    }
    if (!value.contains('@')) {
      return 'Пожалуйста введите корректную почту';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пароль должен быть не менее 6 символов';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }
}
