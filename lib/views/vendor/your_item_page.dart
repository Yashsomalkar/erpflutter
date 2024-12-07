import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/product_provider.dart';

class YourItemsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Items"),
        automaticallyImplyLeading: false,
      ),
      body: products.isEmpty
          ? const Center(child: Text("No products added yet."))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.file(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
              title: Text(product.name),
              subtitle: Text(
                "Price: \$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  ref.read(productProvider.notifier).deleteProduct(product.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
