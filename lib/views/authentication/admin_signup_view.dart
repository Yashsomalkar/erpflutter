import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/utils.dart';
import '../admin/admin_home_page.dart';
import 'sign_in_view.dart'; // Import Sign-In Page

class AdminSignupView extends StatefulWidget {
  @override
  _AdminSignupViewState createState() => _AdminSignupViewState();
}

class _AdminSignupViewState extends State<AdminSignupView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  Future<void> _signupAdmin() async
  {
    if(_nameController.text.isEmpty){
      showSnackBar(context, "Name is Required");
      return;

    }
    if(_emailController.text.isEmpty || !_emailRegExp.hasMatch(_emailController.text)){
      showSnackBar(context, "Please enter a valid email address");
      return;
    }
    if(_passwordController.text.isEmpty || _passwordController.text.length < 6 ){
      showSnackBar(context, "Password must be at least 6 characters long");
      return;
    }
    setState(() {
      _isLoading = true;

    });
    final response = await _authService.registerAdmin({
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text
    });
    setState(() {
      _isLoading = false;
    });
    if(response['success']){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage(),),);
    }else {
      showSnackBar(context, response['message'] ?? "Registration failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ?const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Admin Signup",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signupAdmin,
              child: const Text("Signup as Admin"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInView()),
                    );
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
    );
  }
}
