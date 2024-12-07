import 'package:flutter/material.dart';
import 'your_item_page.dart'; // Create this file for "Your Item" logic
import 'add_new_item_page.dart'; // Create this file for "Add New Item" logic
import 'transaction_page.dart'; // Create this file for "Transaction" logic

class VendorMainPage extends StatefulWidget {
  final String name;
  final String category;

  const VendorMainPage({Key? key, required this.name, required this.category}) : super(key: key);

  @override
  _VendorMainPageState createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  int _currentIndex = 0;

  // Pages for each bottom navigation tab
  final List<Widget> _pages = [
    YourItemsPage(), // "Your Item" page
    AddNewItemPage(), // "Add New Item" page
    TransactionPage(), // "Transaction" page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.name}"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigate back to the sign-in screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: _pages[_currentIndex], // Dynamically switch pages based on selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            backgroundColor: Colors.black,
            label: "Your Items",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            backgroundColor: Colors.black,
            label: "Add Item",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            backgroundColor: Colors.black,
            label: "Transaction",
          ),
        ],
      ),
    );
  }
}
