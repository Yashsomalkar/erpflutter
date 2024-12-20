import 'package:erpapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import '../vendor/vendor_main_page.dart'; // Import the Vendor Homepage

class VendorSignupView extends StatefulWidget {
  @override
  _VendorSignupViewState createState() => _VendorSignupViewState();
}

class _VendorSignupViewState extends State<VendorSignupView> {
  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCategory = "Decoration"; // Default category
  final List<String> _categories = ["Decoration", "Florist", "Lighting", "Catering"];
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  final RegExp _phoneRegExp = RegExp(r"^\d{10}$"); // Matches 10-digit phone numbers

  Future<void> _registerVendor() async {
    if (_nameController.text.isEmpty) {
      showSnackBar(context, "Name is required");
      return;
    }
    if (_businessNameController.text.isEmpty) {
      showSnackBar(context, "Business name is required");
      return;
    }
    if (_emailController.text.isEmpty || !_emailRegExp.hasMatch(_emailController.text)) {
      showSnackBar(context, "Please enter a valid email address");
      return;
    }
    if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
      showSnackBar(context, "Password must be at least 6 characters long");
      return;
    }
    if (_addressController.text.isEmpty) {
      showSnackBar(context, "Address is required");
      return;
    }
    if (_phoneController.text.isEmpty || !_phoneRegExp.hasMatch(_phoneController.text)) {
      showSnackBar(context, "Please enter a valid 10-digit phone number");
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final response = await _authService.register({
      "name" : _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "role": "vendor",
      "business_name": _businessNameController.text,
      "address": _addressController.text,
      "phone": _phoneController.text,
    });
    setState(() {
      _isLoading = false;
    });

    if(response['success']){
      //Navigate to vendor HomePage
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => VendorMainPage(
                name:  _nameController.text,
                category: _selectedCategory,
              )));
    }else{
          showSnackBar(context, response['message'] ?? "Registration failed");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Vendor Signup"),
      // ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
          ? const CircularProgressIndicator()
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Vendor Signup",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _businessNameController,
                decoration: const InputDecoration(labelText: "Business Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerVendor,
                child: const Text("Signup as Vendor"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
