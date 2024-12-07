import 'package:flutter/material.dart';
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

  String _selectedCategory = "Decoration"; // Default category
  final List<String> _categories = ["Decoration", "Florist", "Lighting", "Catering"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vendor Signup"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                onPressed: () {
                  // Navigate to Vendor Homepage with the name and category
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VendorMainPage(
                        name: _nameController.text,
                        category: _selectedCategory,
                      ),
                    ),
                  );
                },
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
