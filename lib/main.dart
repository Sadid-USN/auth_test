import 'package:auth_test/controller/login_controller.dart';
import 'package:auth_test/theme/theme.dart';
import 'package:auth_test/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
       create: (context) {
          return LoginController();
        },
    
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"Test",
      theme: appTheme,
      home: const LoginPage(),
    );
  }
}

