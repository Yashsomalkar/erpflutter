import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'guest_list_screen.dart';
import 'order_status_screen.dart';
import 'order_status_screen.dart';
import 'vendor_screen.dart';
import '../authentication/sign_in_view.dart'; // For logout

class UserHomeScreen extends StatefulWidget {
  final String userName;

  const UserHomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    VendorScreen(),
    CartScreen(),
    OrderStatusScreen(),
    GuestListScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${widget.userName}"),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Navigate back to login screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SignInView()),
                  (route) => false,
            );
          },
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            backgroundColor: Colors.black,
            label: "Vendor",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            backgroundColor: Colors.black,
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            backgroundColor: Colors.black,
            label: "Order Status",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            backgroundColor: Colors.black,
            label: "Guest List",
          ),
        ],
      ),
    );
  }
}
