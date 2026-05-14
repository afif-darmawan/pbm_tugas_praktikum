import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/constants.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';

class ApiService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _userNameKey = 'user_name';
  static const _userUsernameKey = 'user_username';
  static const _userClassKey = 'user_class';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveUserInfo(User user) async {
    await _storage.write(key: _userNameKey, value: user.name);
    await _storage.write(key: _userUsernameKey, value: user.username);
    await _storage.write(key: _userClassKey, value: user.userClass.name);
  }

  static Future<String?> getUserName() async {
    return await _storage.read(key: _userNameKey);
  }

  static Future<String?> getUserUsername() async {
    return await _storage.read(key: _userUsernameKey);
  }

  static Future<String?> getUserClass() async {
    return await _storage.read(key: _userClassKey);
  }

  static Future<void> deleteToken() async {
    await _storage.deleteAll();
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Map<String, String> _headers() {
    return {'Content-Type': 'application/json', 'Accept': 'application/json'};
  }

  static Map<String, String> _authHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.loginEndpoint}',
    );

    try {
      final response = await http.post(
        url,
        headers: _headers(),
        body: jsonEncode({'username': username, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final loginResponse = LoginResponse.fromJson(data);

        await saveToken(loginResponse.token);
        await saveUserInfo(loginResponse.user);
        return loginResponse;
      } else {
        throw Exception(data['message'] ?? 'Login gagal');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Koneksi gagal. Periksa jaringan internet Anda.');
    }
  }

  static Future<ProductListResponse> getProducts() async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Silakan login.');

    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.productsEndpoint}',
    );

    try {
      final response = await http.get(url, headers: _authHeaders(token));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return ProductListResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Gagal mengambil data produk');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Koneksi gagal. Periksa jaringan internet Anda.');
    }
  }

  static Future<Map<String, dynamic>> createProduct({
    required String name,
    required int price,
    required String description,
  }) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Silakan login.');

    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.productsEndpoint}',
    );

    try {
      final response = await http.post(
        url,
        headers: _authHeaders(token),
        body: jsonEncode({
          'name': name,
          'price': price,
          'description': description,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Gagal menyimpan produk');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Koneksi gagal. Periksa jaringan internet Anda.');
    }
  }

  static Future<Map<String, dynamic>> deleteProduct(int productId) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Silakan login.');

    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.productsEndpoint}/$productId',
    );

    try {
      final response = await http.delete(url, headers: _authHeaders(token));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data;
      } else {
        throw Exception(data['message'] ?? 'Gagal menghapus produk');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Koneksi gagal. Periksa jaringan internet Anda.');
    }
  }

  static Future<SubmitResponse> submitAssignment({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    final token = await getToken();
    if (token == null) throw Exception('Token tidak ditemukan. Silakan login.');

    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.submitEndpoint}',
    );

    try {
      final response = await http.post(
        url,
        headers: _authHeaders(token),
        body: jsonEncode({
          'name': name,
          'price': price,
          'description': description,
          'github_url': githubUrl,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return SubmitResponse.fromJson(data);
      } else {
        throw Exception(data['message'] ?? 'Gagal submit tugas');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Koneksi gagal. Periksa jaringan internet Anda.');
    }
  }
}
