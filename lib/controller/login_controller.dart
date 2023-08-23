import 'package:auth_test/API/auth.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {

  var isLogin = false;
  final AuthAPI _authAPI;

  LoginController(this._authAPI);
  // test@gmail.com
  // thisisrlycoolpass
  final phoneTextController = TextEditingController(text: "");
  final passwordTextController =
      TextEditingController(text: "");

  Future<void> doLogin(BuildContext context) async {
    final email = phoneTextController.text;
    final password = passwordTextController.text;

    try {
      final profileData = await _authAPI.login(email, password);

      isLogin = true;
      notifyListeners();
    } catch (e) {
      print('Login failed: $e');
      isLogin = false;
      notifyListeners();

      // Show a snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed: $e'),
      ));
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '* Пожалуйста заполните это поле';
    }
    if (!value.contains('@')) {
      return 'Пожалуйста введите корректную почту';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '* Пожалуйста заполните это поле';
    }
    if (value.length < 8) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }


   void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }
}
