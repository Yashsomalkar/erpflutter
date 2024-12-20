import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../utils/http_logger.dart';
import 'auth_service.dart';

class AdminService {
  final String baseUrl = "http://3.110.122.71:8000"; // Replace with your backend URL
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();
  final http.Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()],
     );
  // Fetch all users
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final token = await _authService.getToken();
    try {
      final response = await client.get(
        Uri.parse("$baseUrl/api/admin/users"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 100));

      // print("Response status: ${response.statusCode}");
      // print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception("Failed to load users: ${response.body}");
      }
    } catch (e) {
      print("Failed to fetch users: $e");
      rethrow;
    }
  }


  // Fetch all vendors
  Future<List<Map<String, dynamic>>> fetchVendors() async {
    final token = await storage.read(key: 'token');
    final response = await client.get(
      Uri.parse("$baseUrl/api/admin/vendors"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception("Failed to load vendors: ${response.body}");
    }
  }
  Future<Map<String, dynamic>> addUser(Map<String, dynamic> user) async {
    final token = await storage.read(key: 'token');
    final response = await client.post(
      Uri.parse('$baseUrl/api/admin/users'),
      body: json.encode(user),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to add user');
    }
  }


  Future<void> updateUser(String userId, Map<String, dynamic> userData) async {
    final token = await storage.read(key: 'token');
    final response = await http.put(
      Uri.parse("$baseUrl/api/admin/users/$userId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update user: ${response.body}");
    }
  }

  Future<void> deleteUser(String userId) async {
    final token = await storage.read(key: 'token');
    final response = await http.delete(
      Uri.parse("$baseUrl/api/admin/users/$userId"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete user: ${response.body}");
    }
  }

}
