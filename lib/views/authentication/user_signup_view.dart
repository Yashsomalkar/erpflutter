import 'package:flutter/material.dart';
import '../user/user_home_screen.dart'; // Import the User Home Screen
import 'sign_in_view.dart'; // Import the Sign-In Page

class UserSignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "User Signup",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to User Home Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomeScreen(userName: "John Doe"), // Replace "User" with dynamic username
                  ),
                );
              },
              child: const Text("Signup as User"),
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
