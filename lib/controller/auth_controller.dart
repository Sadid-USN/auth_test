import 'package:auth_test/API/auth.dart';
import 'package:auth_test/core/constant.dart';
import 'package:auth_test/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    final phone = phoneController.text;

    try {
      profileData = await _authAPI.login(email, password);
      token = profileData.tokens!.accessToken;
      profileData = profileData;
      print("AccessToken ----> ${profileData.tokens!.accessToken}");

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

  void logout() {
    token = null;

    token = _authAPI.logout();
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

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;

          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  void navigateReplacement(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, -1.0); // Start from top
          const end = Offset.zero; // End at the current position

          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
