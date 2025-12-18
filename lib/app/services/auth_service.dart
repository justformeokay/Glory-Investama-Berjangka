import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _baseUrl = 'https://api.example.com'; // Replace with your API
  static const String _loginEndpoint = '$_baseUrl/auth/login';

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_loginEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return AuthResponse.fromJson(json);
      } else if (response.statusCode == 401) {
        final json = jsonDecode(response.body);
        throw AuthException(
          message: json['message'] ?? 'Invalid credentials',
          code: 'INVALID_CREDENTIALS',
        );
      } else if (response.statusCode == 404) {
        throw AuthException(
          message: 'User not found',
          code: 'USER_NOT_FOUND',
        );
      } else {
        throw AuthException(
          message: 'Server error. Please try again later.',
          code: 'SERVER_ERROR',
        );
      }
    } on SocketException {
      throw AuthException(
        message: 'No internet connection',
        code: 'NO_CONNECTION',
      );
    } on TimeoutException {
      throw AuthException(
        message: 'Request timeout. Please try again.',
        code: 'TIMEOUT',
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(
        message: 'An unexpected error occurred',
        code: 'UNKNOWN_ERROR',
      );
    }
  }

  Future<void> logout() async {
    try {
      // Clear local data
      // await storage.delete(key: 'auth_token');
    } catch (e) {
      throw AuthException(
        message: 'Logout failed',
        code: 'LOGOUT_ERROR',
      );
    }
  }
}

class AuthResponse {
  final String token;
  final String refreshToken;
  final String userId;
  final String email;
  final String name;

  AuthResponse({
    required this.token,
    required this.refreshToken,
    required this.userId,
    required this.email,
    required this.name,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? json['access_token'] ?? '',
      refreshToken: json['refreshToken'] ?? json['refresh_token'] ?? '',
      userId: json['userId'] ?? json['user_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class AuthException implements Exception {
  final String message;
  final String code;

  AuthException({
    required this.message,
    required this.code,
  });

  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => message;
}

class SocketException implements Exception {
  final String message;

  SocketException(this.message);

  @override
  String toString() => message;
}
