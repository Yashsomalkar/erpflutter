import 'package:flutter/material.dart';

class MaintainUserPage extends StatefulWidget {
  @override
  _MaintainUserPageState createState() => _MaintainUserPageState();
}

class _MaintainUserPageState extends State<MaintainUserPage> {
  final List<Map<String, String>> _users = [
    {"name": "Alice", "email": "alice@example.com", "membership": "Premium"},
    {"name": "Bob", "email": "bob@example.com", "membership": "Basic"},
    {"name": "Charlie", "email": "charlie@example.com", "membership": "Premium"},
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedMembership = "Basic";

  void _addUser() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _selectedMembership == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    setState(() {
      _users.add({
        "name": _nameController.text,
        "email": _emailController.text,
        "membership": _selectedMembership!,
      });
    });

    _nameController.clear();
    _emailController.clear();
    _selectedMembership = "Basic";
    Navigator.of(context).pop();
  }

  void _editUser(int index) {
    _nameController.text = _users[index]["name"]!;
    _emailController.text = _users[index]["email"]!;
    _selectedMembership = _users[index]["membership"];

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
              value: _selectedMembership,
              onChanged: (value) {
                setState(() {
                  _selectedMembership = value!;
                });
              },
              items: ["Basic", "Premium"].map((membership) {
                return DropdownMenuItem<String>(
                  value: membership,
                  child: Text(membership),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: "Membership"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _users[index] = {
                  "name": _nameController.text,
                  "email": _emailController.text,
                  "membership": _selectedMembership!,
                };
              });
              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteUser(int index) {
    setState(() {
      _users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintain User"),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(user["name"]!),
              subtitle: Text("${user["email"]!} - ${user["membership"]!}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editUser(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteUser(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                    value: _selectedMembership,
                    onChanged: (value) {
                      setState(() {
                        _selectedMembership = value!;
                      });
                    },
                    items: ["Basic", "Premium"].map((membership) {
                      return DropdownMenuItem<String>(
                        value: membership,
                        child: Text(membership),
                      );
                    }).toList(),
                    decoration: const InputDecoration(labelText: "Membership"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
