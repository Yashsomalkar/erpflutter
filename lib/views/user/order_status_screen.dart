import 'package:flutter/material.dart';
import 'user_home_screen.dart'; // Import User Home Screen
import '../authentication/sign_in_view.dart'; // Import Sign-In View

class OrderStatusScreen extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      "name": "John Doe",
      "email": "john@example.com",
      "address": "123 Street, City",
      "status": "Pending",
    },
    {
      "name": "Jane Smith",
      "email": "jane@example.com",
      "address": "456 Avenue, City",
      "status": "Completed",
    },
    {
      "name": "Michael Brown",
      "email": "michael@example.com",
      "address": "789 Boulevard, City",
      "status": "Cancelled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Status"),
        automaticallyImplyLeading: false,
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       // Navigate to Home
        //       Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (context) => UserHomeScreen(userName: "John Doe")),
        //             (route) => false,
        //       );
        //     },
        //     child: const Text(
        //       "Home",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        //   TextButton(
        //     onPressed: () {
        //       // Logout and navigate to Sign-In
        //       Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(builder: (context) => SignInView()),
        //             (route) => false,
        //       );
        //     },
        //     child: const Text(
        //       "Logout",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                title: Text(order["name"]!),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${order["email"]}"),
                    Text("Address: ${order["address"]}"),
                    Text("Status: ${order["status"]}"),
                  ],
                ),
                trailing: Icon(
                  order["status"] == "Completed"
                      ? Icons.check_circle
                      : order["status"] == "Pending"
                      ? Icons.hourglass_top
                      : Icons.cancel,
                  color: order["status"] == "Completed"
                      ? Colors.green
                      : order["status"] == "Pending"
                      ? Colors.orange
                      : Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
