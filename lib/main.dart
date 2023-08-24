import 'dart:async';

import 'package:auth_test/API/auth.dart';
import 'package:auth_test/controller/auth_controller.dart';
import 'package:auth_test/theme/theme.dart';
import 'package:auth_test/view/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final talker = TalkerFlutter.init();
    GetIt.I.registerSingleton(talker);
    final dio = Dio();
    dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printResponseData: false,
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
    final authAPI = AuthImpl(dio,);

    runApp(ChangeNotifierProvider(
        create: (context) {
          return AuthController(authAPI);
        },
        child: const MyApp()));
  }, (error, stack) {
    return GetIt.I<Talker>().handle(error, stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        TalkerRouteObserver(GetIt.I<Talker>()),
      ],
      debugShowCheckedModeBanner: false,
      title: "Test",
      theme: appTheme,
      home: const LoginPage(),
    );
  }
}
