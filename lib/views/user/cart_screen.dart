import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        automaticallyImplyLeading: false,
      ),
      body: cart.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    ),
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price: \$${product.price.toStringAsFixed(2)}"),
                        Text(
                          "Total: \$${(product.price * product.quantity).toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (product.quantity > 1) {
                              cartNotifier.removeProduct(product.id);
                            } else {
                              cartNotifier.removeProduct(product.id);
                              cartNotifier.deleteProduct(product.id);
                            }
                            setState(() {});
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text("${product.quantity}"),
                        IconButton(
                          onPressed: () {
                            cartNotifier.addProduct(product);
                            setState(() {});
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Grand Total: \$${cartNotifier.totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (cart.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Your cart is empty!")),
                      );
                      return;
                    }

                    // Save totalAmount before clearing the cart
                    final totalAmount = cartNotifier.totalAmount;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(totalAmount: totalAmount),
                      ),
                    );

                    // Clear cart after navigation
                    cartNotifier.clearCart();
                    setState(() {});
                  },
                  child: const Text("Checkout"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    cartNotifier.clearCart();
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text("Clear Cart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
