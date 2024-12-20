import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/user_view_model.dart';

class MaintainUserPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userProvider);
    final isLoading = ref.watch(userProvider.notifier).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintain Users"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? const Center(child: Text("No users available"))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(user.name),
              subtitle: Text("${user.email} - ${user.role}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editUser(context, ref, user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(context, ref, user.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addUser(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addUser(BuildContext context, WidgetRef ref) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    String? _selectedRole = "user";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (value) {
                _selectedRole = value;
              },
              items: ["admin", "user", "vendor"].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All fields are required!")),
                );
                return;
              }

              await ref.read(userProvider.notifier).addUser(
                _nameController.text,
                _emailController.text,
                _selectedRole!,
              );
              Navigator.of(context).pop();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _editUser(BuildContext context, WidgetRef ref, User user) {
    final _nameController = TextEditingController(text: user.name);
    final _emailController = TextEditingController(text: user.email);
    String? _selectedRole = user.role;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              onChanged: (value) {
                _selectedRole = value;
              },
              items: ["admin", "user", "vendor"].map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All fields are required!")),
                );
                return;
              }

              await ref.read(userProvider.notifier).updateUser(
                user.id,
                _nameController.text,
                _emailController.text,
                _selectedRole!,
              );
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteUser(BuildContext context, WidgetRef ref, String userId) async {
    try {
      await ref.read(userProvider.notifier).deleteUser(userId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete user: $e")),
      );
    }
  }
}
