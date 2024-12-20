import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/admin_service.dart';

class User {
  String id;
  String name;
  String email;
  String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class UserNotifier extends StateNotifier<List<User>> {
  final AdminService _adminService = AdminService();

  // Add a loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserNotifier() : super([]) {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    _setLoading(true);
    try {
      print("Fetching users...");
      final users = await _adminService.fetchUsers();
      print("Users fetched successfully: $users");

      state = users.map((user) {
        return User(
          id: user['_id'] ?? '',
          name: user['name'] ?? 'Unknown',
          email: user['email'] ?? '',
          role: user['role'] ?? 'N/A',
        );
      }).toList();
    } catch (e) {
      print("Failed to load users at view model: $e");
    } finally {
      _setLoading(false);
    }
  }
  Future<void> addUser(String name, String email, String role) async {
    _setLoading(true);
    try {
      final newUser = await _adminService.addUser({
        'name': name,
        'email': email,
        'membership': role,
      });

      state = [
        ...state,
        User(
          id: newUser['_id'] ?? '',
          name: newUser['name'] ?? 'Unknown',
          email: newUser['email'] ?? '',
          role: newUser['role'] ?? 'N/A',
        ),
      ];
    } catch (e) {
      print("Failed to add user: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUser(String id, String name, String email, String role) async {
    _setLoading(true);
    try {
      await _adminService.updateUser(id, {
        'name': name,
        'email': email,
        'role': role,
      });

      state = state.map((user) {
        if (user.id == id) {
          return User(id: id, name: name, email: email, role: role);
        }
        return user;
      }).toList();
    } catch (e) {
      print("Failed to update user: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteUser(String id) async {
    _setLoading(true);
    try {
      await _adminService.deleteUser(id);

      state = state.where((user) => user.id != id).toList();
    } catch (e) {
      print("Failed to delete user: $e");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    // Trigger rebuild by notifying listeners
    state = [...state];
  }
}

final userProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) => UserNotifier());
