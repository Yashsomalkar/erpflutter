import 'package:flutter/material.dart';

class Transaction {
  final String id;
  final String productName;
  final int quantity;
  final double totalPrice;
  final String buyerName;
  final DateTime date;

  Transaction({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.totalPrice,
    required this.buyerName,
    required this.date,
  });
}

class TransactionPage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: "T001",
      productName: "Buffet Service",
      quantity: 3,
      totalPrice: 599.97,
      buyerName: "John Doe",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: "T002",
      productName: "Wedding Flowers",
      quantity: 2,
      totalPrice: 179.98,
      buyerName: "Jane Smith",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: "T003",
      productName: "Fairy Lights",
      quantity: 5,
      totalPrice: 149.95,
      buyerName: "Michael Johnson",
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: "T004",
      productName: "Stage Decoration",
      quantity: 1,
      totalPrice: 399.99,
      buyerName: "Emily Davis",
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        automaticallyImplyLeading: false,
      ),
      body: transactions.isEmpty
          ? const Center(
        child: Text(
          "No transactions found.",
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  transaction.productName[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(transaction.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Buyer: ${transaction.buyerName}"),
                  Text("Quantity: ${transaction.quantity}"),
                  Text("Total: \$${transaction.totalPrice.toStringAsFixed(2)}"),
                  Text("Date: ${transaction.date.toLocal()}".split('.')[0]),
                ],
              ),
              trailing: Text(
                "ID: ${transaction.id}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
