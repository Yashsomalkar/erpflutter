import 'package:flutter/material.dart';
import '../user/user_home_screen.dart'; // Import User Home Page
import '../admin/admin_home_page.dart'; // Import Admin Home Page
import '../user/vendor_screen.dart';
import '../vendor/vendor_main_page.dart';


class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final List<String> _roles = ["User", "Admin", "Vendor"];
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                items: _roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Select Role",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_selectedRole == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a role")),
                    );
                    return;
                  }

                  // Navigate based on selected role
                  if (_selectedRole == "User") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UserHomeScreen(userName: 'John Doe',)),
                    );
                  } else if (_selectedRole == "Admin") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                    );
                  } else if (_selectedRole == "Vendor") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => VendorMainPage(name: 'Ramu kaka', category: 'Flourist',)),
                    );
                  }
                },
                child: const Text("Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
