import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../views/authentication/sign_in_view.dart';

class AuthService {
  final String baseUrl = "http://3.110.122.71:8000"; // Replace with your backend URL
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/login"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Store token locally
      await storage.write(key: 'token', value: data['token']);
      // Return role and success
      return {'success': true, 'role': data['role']};
    } else {
      // Login failed
      return {'success': false, 'message': 'Invalid credentials'};
    }
  }
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
        Uri.parse("$baseUrl/api/auth/register"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      )
          .timeout(Duration(seconds: 10)); // Set timeout to 10 seconds

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registered successfully'};
      } else {
        final errorData = json.decode(response.body);
        return {'success': false, 'message': errorData['error'] ?? 'Failed to register'};
      }
    } on http.ClientException catch (e) {
      return {'success': false, 'message': 'Network issue: ${e.message}'};
    } on TimeoutException {
      return {'success': false, 'message': 'Request timed out. Check your internet connection.'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }
  Future<Map<String, dynamic>> registerAdmin(Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(
        Uri.parse("$baseUrl/api/auth/register/admin"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      )
          .timeout(Duration(seconds: 10)); // Set timeout to 10 seconds

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registered successfully'};
      } else {
        final errorData = json.decode(response.body);
        return {'success': false, 'message': errorData['error'] ?? 'Failed to register'};
      }
    } on http.ClientException catch (e) {
      return {'success': false, 'message': 'Network issue: ${e.message}'};
    } on TimeoutException {
      return {'success': false, 'message': 'Request timed out. Check your internet connection.'};
    } catch (e) {
      return {'success': false, 'message': 'Unexpected error: $e'};
    }
  }
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInView()), // Navigate to login
          (route) => false, // Remove all previous routes
    );
  }
}
