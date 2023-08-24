import 'package:auth_test/controller/auth_controller.dart';
import 'package:auth_test/view/profile_page.dart';
import 'package:auth_test/view/signup_page.dart';
import 'package:auth_test/widget/app_button.dart';
import 'package:auth_test/widget/app_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer<AuthController>(
      builder: (context, controller, _) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<AuthController>(
                builder: (context, value, child) {
                  final emailController = value.emailloginController;

                  controller.getEmailFromSharedPreferences().then((email) {
                    if (email != null) {
                      emailController.text = email;
                    }
                  });
                  return AppTextField(
                    validator: controller.validateEmail,
                    textEditingController: emailController,
                    hintText: 'Логин или почта',
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  thickness: 0.2,
                  height: 1.7,
                ),
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppTextField(
                  validator: value.validatePassword,
                  textEditingController: value.passwordLoginController,
                  hintText: 'Пароль',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer<AuthController>(
                builder: (context, controller, child) => AppButton(
                  backgroundColor: const Color(0xff4631D2),
                  textColor: Colors.white,
                  title: "Войти",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await controller.doLogin(context);

                      if (controller.isLogin && context.mounted) {
                        controller.navigateToPage(context, const ProfilePage());
                      }
                    }
                  },
                ),
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppButton(
                  backgroundColor: const Color(0xff4631D2),
                  textColor: Colors.white,
                  title: "Зарегистрироваться",
                  onTap: () {
                    value.navigateToPage(context, const SignUpPage());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
