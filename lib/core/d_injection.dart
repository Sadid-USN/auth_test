import 'package:auth_test/API/auth.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDependencies(AuthImpl authAPI) async {
   final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  final dio = Dio();
   final authAPI = AuthImpl(dio);
  // interceptors Получает информацию о любом запросе, который производит клиент Dio
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


 
 


}