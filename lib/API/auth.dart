import 'package:auth_test/models/login_model.dart';
import 'package:dio/dio.dart';

abstract class AuthAPI {
  Future<LoginModel> login(String email, String password);
  Future<LoginModel> signUp(
    String email,
    String password,
    String nickName,
    String phone,
  );
  Future<LoginModel> getProfileData(String token);
  String logout();
}

class AuthImpl implements AuthAPI {
  final Dio _dio;
  late String _token;

  static const String _baseUrl = 'http://45.10.110.181:8080/api/v1';

  static const String _loginEndpoint = 'auth/login';
  static const String _profileEndpoint = 'auth/login/profile';
  static const String _signUpEndpoint = 'auth/registration/customer/new';

  AuthImpl(this._dio);

  Future<LoginModel> _handleRequest(Future<Response<dynamic>> request) async {
    try {
      final response = await request;

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Request failed with status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }

  @override
  Future<LoginModel> signUp(
      String email, String password, String nickName, String phone) async {
    final requestData = {
      'email': email,
      'password': password,
      'nickname': nickName,
      "phone": phone
    };
    final request = _dio.post('$_baseUrl/$_signUpEndpoint', data: requestData);
    return _handleRequest(request);
  }

  @override
  Future<LoginModel> login(String email, String password) async {
    final requestData = {'email': email, 'password': password};
    final request = _dio.post('$_baseUrl/$_loginEndpoint', data: requestData);
    return _handleRequest(request);
  }

  @override
  Future<LoginModel> getProfileData(String token) async {
    final request = _dio.get('$_baseUrl/$_profileEndpoint',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return _handleRequest(request);
  }

  @override
  String logout() {
   return _token = '';
  }
}
