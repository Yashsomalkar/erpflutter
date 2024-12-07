import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Product model
class Product {
  String id;
  String name;
  double price;
  File image;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

// StateNotifier to manage the list of products
class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier() : super([]);

  // Add a new product
  void addProduct(Product product) {
    state = [...state, product];
  }

  // Delete a product
  void deleteProduct(String productId) {
    state = state.where((product) => product.id != productId).toList();
  }
}

// RiverPod provider for products
final productProvider = StateNotifierProvider<ProductNotifier, List<Product>>(
        (ref) => ProductNotifier());
