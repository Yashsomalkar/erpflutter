import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  CheckoutScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String _name = "";
  String _email = "";
  String _address = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  String _number = "";
  String _paymentMethod = "Cash";

  final List<String> _paymentMethods = ["Cash", "UPI"];

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Thank You!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total Amount: \$${widget.totalAmount.toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            Text("Name: $_name"),
            Text("Email: $_email"),
            Text("Address: $_address"),
            Text("City: $_city"),
            Text("Phone Number: $_number"),
            Text("Payment Method: $_paymentMethod"),
            Text("State: $_state"),
            Text("Pincode: $_pincode"),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Navigate back to the previous page
            },
            child: const Text("Continue Shopping"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Grand Total: \$${widget.totalAmount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Name
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              const SizedBox(height: 10),
              // Email
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 10),
              // Address
              TextFormField(
                decoration: const InputDecoration(labelText: "Address"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              const SizedBox(height: 10),
              // City
              TextFormField(
                decoration: const InputDecoration(labelText: "City"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your city";
                  }
                  return null;
                },
                onSaved: (value) => _city = value!,
              ),
              const SizedBox(height: 10),
              // State
              TextFormField(
                decoration: const InputDecoration(labelText: "State"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your state";
                  }
                  return null;
                },
                onSaved: (value) => _state = value!,
              ),
              const SizedBox(height: 10),
              // Pincode
              TextFormField(
                decoration: const InputDecoration(labelText: "Pincode"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your pincode";
                  }
                  if (value.length != 6) {
                    return "Please enter a valid 6-digit pincode";
                  }
                  return null;
                },
                onSaved: (value) => _pincode = value!,
              ),
              const SizedBox(height: 10),
              // Phone Number
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  if (value.length != 10) {
                    return "Please enter a valid 10-digit phone number";
                  }
                  return null;
                },
                onSaved: (value) => _number = value!,
              ),
              const SizedBox(height: 10),
              // Payment Method
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: const InputDecoration(labelText: "Payment Method"),
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a payment method";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Order Now Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _showThankYouDialog();
                  }
                },
                child: const Text("Order Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
