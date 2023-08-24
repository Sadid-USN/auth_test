import 'package:auth_test/controller/auth_controller.dart';
import 'package:auth_test/view/login_page.dart';

import 'package:auth_test/view/signup_page.dart';
import 'package:auth_test/widget/app_button.dart';
import 'package:auth_test/widget/app_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

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
                builder: (context, value, child) => AppTextField(
                  validator: controller.validateEmail,
                  textEditingController: value.emailSignUpController,
                  hintText: 'Логин или почта',
                ),
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppTextField(
                  validator: controller.validateNickName,
                  textEditingController: value.nickNameController,
                  hintText: 'Никнейм',
                ),
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppTextField(
                  validator: controller.validatePhone,
                  textEditingController: value.phoneController,
                  hintText: 'Номер телефона',
                ),
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
                  textEditingController: value.passwordSignUpController,
                  hintText: 'Пароль',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer<AuthController>(
                builder: (context, value, child) => AppButton(
                  backgroundColor: const Color(0xff4631D2),
                  textColor: Colors.white,
                  title: "Зарегистрироваться",
                  onTap: () async{
                          if (formKey.currentState!.validate()) {
                      await controller.doSignUp(context);

                      if (controller.isLogin && context.mounted) {
                        controller.navigateReplacement(context,  const LoginPage());
                      }
                    }
                  
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
