import 'package:flutter/material.dart';

class MaintainVendorPage extends StatefulWidget {
  @override
  _MaintainVendorPageState createState() => _MaintainVendorPageState();
}

class _MaintainVendorPageState extends State<MaintainVendorPage> {
  final List<Map<String, String>> _vendors = [
    {"business_name": "Elegant Events", "email": "elegant@events.com", "membership": "Gold"},
    {"business_name": "Floral Creations", "email": "floral@creations.com", "membership": "Silver"},
    {"business_name": "Bright Lights Co.", "email": "bright@lights.com", "membership": "Platinum"},
  ];

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedMembership = "Silver";

  void _addVendor() {
    if (_businessNameController.text.isEmpty || _emailController.text.isEmpty || _selectedMembership == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    setState(() {
      _vendors.add({
        "business_name": _businessNameController.text,
        "email": _emailController.text,
        "membership": _selectedMembership!,
      });
    });

    _businessNameController.clear();
    _emailController.clear();
    _selectedMembership = "Silver";
    Navigator.of(context).pop();
  }

  void _editVendor(int index) {
    _businessNameController.text = _vendors[index]["business_name"]!;
    _emailController.text = _vendors[index]["email"]!;
    _selectedMembership = _vendors[index]["membership"];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Vendor"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _businessNameController,
              decoration: const InputDecoration(labelText: "Business Name"),
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
              items: ["Silver", "Gold", "Platinum"].map((membership) {
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
                _vendors[index] = {
                  "business_name": _businessNameController.text,
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

  void _deleteVendor(int index) {
    setState(() {
      _vendors.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maintain Vendor"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _vendors.length,
        itemBuilder: (context, index) {
          final vendor = _vendors[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(vendor["business_name"]!),
              subtitle: Text("${vendor["email"]!} - ${vendor["membership"]!}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editVendor(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteVendor(index),
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
              title: const Text("Add Vendor"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _businessNameController,
                    decoration: const InputDecoration(labelText: "Business Name"),
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
                    items: ["Silver", "Gold", "Platinum"].map((membership) {
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
                  onPressed: _addVendor,
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
