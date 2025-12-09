import 'package:dio/dio.dart';
import 'package:flutter_nhom6/model/user.dart';

class API {
  String? _token;

  // Đăng nhập
  Future<Map<String, dynamic>?> login(String username, String password) async {
    var dio = Dio();
    try {
      var response = await dio.post(
        'https://dummyjson.com/auth/login',
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        _token = response.data['accessToken'] ?? response.data['token'];
        return response.data;
      }
    } catch (e) {
      print('Lỗi đăng nhập: $e');
    }
    return null;
  }

  // Lấy thông tin user đã đăng nhập
  Future<User?> getMyProfile() async {
    if (_token == null) {
      return null;
    }

    var dio = Dio();
    try {
      var response = await dio.get(
        'https://dummyjson.com/auth/me',
        options: Options(headers: {'Authorization': 'Bearer $_token'}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } catch (e) {
      print('Lỗi lấy thông tin: $e');
    }
    return null;
  }
}

var test_api = API();
