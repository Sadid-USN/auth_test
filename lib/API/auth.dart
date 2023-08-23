import 'package:auth_test/models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class AuthAPI {
  Future<ProfileModel> login(String email, String password);
}

class AuthImpl implements AuthAPI {
  final Dio _dio;

  AuthImpl(this._dio);

  @override
  Future<ProfileModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'http://45.10.110.181:8080/api/v1/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final profileData = ProfileModel.fromJson(response.data);
        return profileData;
      } else {
        throw Exception('Login failed'); // Adjust error handling as needed
      }
    } catch (e) {
      throw Exception('Login failed: $e'); // Adjust error handling as needed
    }
  }
}
