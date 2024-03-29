import 'package:auth_test/widget/login_body.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  static const LOGIN = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Авторизация",
          style: Theme.of(context).textTheme.titleLarge
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginViewBody(),
          ],
        ),
      ),
    );
  }
}
