import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => "Catering");

// Define a product model
class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String image;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    this.quantity = 0,
  });
}

// Define a provider for managing cart state
class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  // Add a product to the cart
  void addProduct(Product product) {
    final existingProduct = state.firstWhere(
          (item) => item.id == product.id,
      orElse: () => Product(
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price,
        category: product.category,
      ),
    );

    if (state.contains(existingProduct)) {
      existingProduct.quantity++;
    } else {
      product.quantity = 1;
      state = [...state, product];
    }
  }

  // Remove a product or decrement its quantity
  void removeProduct(String productId) {
    final product = state.firstWhere((item) => item.id == productId);
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      state = state.where((item) => item.id != productId).toList();
    }
  }

  // Delete a product completely from the cart
  void deleteProduct(String productId) {
    state = state.where((item) => item.id != productId).toList();
  }

  // Remove all items
  void clearCart() {
    state = [];
  }

  // Calculate the total price
  double get totalAmount {
    return state.fold(0.0, (sum, item) => sum + item.price * item.quantity);
  }
}

// Riverpod provider for the cart
final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) => CartNotifier());
