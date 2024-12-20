import 'package:flutter/material.dart';
import '../authentication/admin_signup_view.dart';
import '../authentication/vendor_signup_view.dart';
import '../authentication/user_signup_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedRole = "User Signup"; // Default role

  // Map the roles to their respective widgets
  final Map<String, Widget> _signupViews = {
    "User Signup": UserSignupView(),
    "Vendor Signup": VendorSignupView(),
    "Admin Signup": AdminSignupView(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Portal"),
        automaticallyImplyLeading: false,
        actions: [
          DropdownButton<String>(
            value: _selectedRole,
            items: _signupViews.keys
                .map((role) => DropdownMenuItem<String>(
              value: role,
              child: Text(role,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500)),
            ))
                .toList(),
            onChanged: (newRole) {
              setState(() {
                _selectedRole = newRole!;
              });
            },
            underline: SizedBox(), // Removes default underline
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.white,
          ),
        ],
      ),
      body: _signupViews[_selectedRole] ?? const SizedBox.shrink(),
    );
  }
}
