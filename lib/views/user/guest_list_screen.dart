import 'package:flutter/material.dart';

class Guest {
  String id;
  String name;
  String phone;
  String email;

  Guest({required this.id, required this.name, required this.phone, required this.email});
}

class GuestListScreen extends StatefulWidget {
  @override
  _GuestListScreenState createState() => _GuestListScreenState();
}

class _GuestListScreenState extends State<GuestListScreen> {
  final List<Guest> _guestList = [];
  final _formKey = GlobalKey<FormState>();
  String _guestName = "";
  String _guestPhone = "";
  String _guestEmail = "";

  // Add a new guest
  void _addGuest() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _guestList.add(Guest(
          id: DateTime.now().toString(),
          name: _guestName,
          phone: _guestPhone,
          email: _guestEmail,
        ));
      });
      Navigator.pop(context);
    }
  }

  // Update a guest's details
  void _updateGuest(String id) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        final guest = _guestList.firstWhere((guest) => guest.id == id);
        guest.name = _guestName;
        guest.phone = _guestPhone;
        guest.email = _guestEmail;
      });
      Navigator.pop(context);
    }
  }

  // Delete a guest
  void _deleteGuest(String id) {
    setState(() {
      _guestList.removeWhere((guest) => guest.id == id);
    });
  }

  // Show dialog for adding or updating a guest
  void _showGuestDialog({String? id}) {
    final isUpdating = id != null;

    if (isUpdating) {
      final guest = _guestList.firstWhere((guest) => guest.id == id);
      _guestName = guest.name;
      _guestPhone = guest.phone;
      _guestEmail = guest.email;
    } else {
      _guestName = "";
      _guestPhone = "";
      _guestEmail = "";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isUpdating ? "Update Guest" : "Add Guest"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _guestName,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the name";
                  }
                  return null;
                },
                onSaved: (value) => _guestName = value!,
              ),
              TextFormField(
                initialValue: _guestPhone,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the phone number";
                  }
                  if (value.length != 10) {
                    return "Please enter a valid 10-digit phone number";
                  }
                  return null;
                },
                onSaved: (value) => _guestPhone = value!,
              ),
              TextFormField(
                initialValue: _guestEmail,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the email address";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
                onSaved: (value) => _guestEmail = value!,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => isUpdating ? _updateGuest(id!) : _addGuest(),
            child: Text(isUpdating ? "Update" : "Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest List"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showGuestDialog(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _guestList.isEmpty
          ? const Center(child: Text("No guests added yet."))
          : ListView.builder(
        itemCount: _guestList.length,
        itemBuilder: (context, index) {
          final guest = _guestList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(guest.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone: ${guest.phone}"),
                  Text("Email: ${guest.email}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _showGuestDialog(id: guest.id),
                    icon: const Icon(Icons.edit, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () => _deleteGuest(guest.id),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
