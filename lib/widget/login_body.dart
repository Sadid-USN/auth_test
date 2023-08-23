import 'package:auth_test/controller/login_controller.dart';
import 'package:auth_test/widget/app_button.dart';
import 'package:auth_test/widget/app_text_filed.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer<LoginController>(
      builder: (context, controller, _) {
        if (controller.isLogin) {
          return const CircularProgressIndicator();
        } else {
          return Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<LoginController>(
                  builder: (context, value, child) => AppTextField(
                    validator:  controller.validateEmail,
                    textEditingController: value.phoneTextController,
                
                    hintText: 'Логин или почта',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.2,
                    height: 1.7,
                  ),
                ),
                Consumer<LoginController>(
                  builder: (context, value, child) => AppTextField(
                    validator: value.validatePassword,
                    textEditingController: value.passwordTextController,
                    
                    hintText: 'Пароль',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                AppButton(
                  title: "Войти",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print('LOGIN');
                    }
                  },
                ),
                AppButton(
                  title: "Зарегистрироваться",
                  onTap: () {},
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
