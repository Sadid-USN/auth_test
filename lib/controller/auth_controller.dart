import 'package:auth_test/API/auth.dart';
import 'package:auth_test/core/constant.dart';
import 'package:auth_test/models/login_model.dart';
import 'package:auth_test/view/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  var isLogin = false;
  final AuthAPI _authAPI;
  int selectedIndex = 3;

  final navItems = [
    SvgPicture.asset(SvgPath.meal),
    SvgPicture.asset(SvgPath.map),
    SvgPicture.asset(SvgPath.favorite),
    SvgPicture.asset(SvgPath.profile),
  ];

  void onTapBar(int index) {
    selectedIndex = index;

    notifyListeners();
  }

  AuthController(this._authAPI);
  // test@gmail.com
  // thisisrlycoolpass
  final emailloginController = TextEditingController(text: "");
  final passwordLoginController = TextEditingController(text: "");

  // SIGN UP CONTROLLERS
  final emailSignUpController = TextEditingController(text: "");
  final nickNameController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final passwordSignUpController = TextEditingController(text: "");

  LoginModel profileData = LoginModel();
  LoginModel signUpDta = LoginModel();

  String? token;

  Future<LoginModel?> getProfile() async {
    try {
      isLogin = true;
      final profileData = await _authAPI.getProfileData(token!);

      notifyListeners();
      return profileData;
    } catch (e) {
      print('Get Profile failed: $e');
      isLogin = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> doLogin(BuildContext context) async {
    final email = emailloginController.text;
    final password = passwordLoginController.text;

    try {
      profileData = await _authAPI.login(email, password);
      token = profileData.tokens!.accessToken;
      profileData = profileData;
      print("AccessToken ----> ${profileData.tokens!.accessToken}");
      saveEmailToSharedPreferences(email);
      isLogin = true;
      notifyListeners();
    } catch (e) {
      isLogin = false;
      notifyListeners();
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Ошибка входа!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: const Text(
                  'Пожалуйста, удостоверьтесь в правильности введенных вами данных.'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void logout(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Выход из аккаунта'),
          content:
              const Text('Вы действительно хотите выйти из своего аккаунта?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                navigateReplacement(context, const LoginPage());
                performLogout();
              },
              child: const Text('Выйти'),
            ),
          ],
        );
      },
    );
  }

  void performLogout() {
    token = null;
    emailloginController.clear();
    passwordLoginController.clear();
    isLogin = false;
    notifyListeners();
  }

  Future<void> doSignUp(BuildContext context) async {
    final email = emailSignUpController.text;
    final password = passwordSignUpController.text;
    final nickname = nickNameController.text;
    final phone = phoneController.text;

    try {
      signUpDta = await _authAPI.signUp(email, password, nickname, phone);
      token = signUpDta.tokens!.accessToken;
      signUpDta = signUpDta;
      print("AccessToken ----> ${signUpDta.tokens!.accessToken}");

      isLogin = true;
      notifyListeners();
    } catch (e) {
      isLogin = false;
      notifyListeners();

      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Ошибка регистрации!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: const Text('Произошла ошибка при регистрации'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: const Text('Ок'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // SharedPreferences ====================

  Future<void> saveEmailToSharedPreferences(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  Future<void> clearEmailFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
  }

  Future<String?> getEmailFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  // VALIDATORS ========================

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '* Пожалуйста заполните это поле';
    }
    if (!value.contains('@')) {
      return 'Пожалуйста введите корректную почту';
    }
    return null;
  }

  String? validateNickName(String? value) {
    if (value == null || value.isEmpty) {
      return '* Пожалуйста заполните это поле';
    }
    if (value.length < 4) {
      return 'Не менее 4 символов';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return '* Пожалуйста заполните это поле';
    }
    if (value.length < 11) {
      return 'Не менее 11 символов';
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

  // NAVIGATORS ========================

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;

          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          // Clear controllers
          emailSignUpController.clear();
          nickNameController.clear();
          phoneController.clear();
          passwordSignUpController.clear();

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  void navigateReplacement(BuildContext context, Widget page) {
    // Clear controllers here before navigation
    emailSignUpController.clear();
    nickNameController.clear();
    phoneController.clear();
    passwordSignUpController.clear();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;

          final tween = Tween(begin: begin, end: end);
          final scaleAnimation = animation.drive(tween);

          return ScaleTransition(
            scale: scaleAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}
