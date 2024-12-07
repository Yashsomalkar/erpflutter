import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/product_provider.dart';
import 'package:image_picker/image_picker.dart';

class AddNewItemPage extends ConsumerStatefulWidget {
  @override
  _AddNewItemPageState createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends ConsumerState<AddNewItemPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _addProduct(WidgetRef ref) {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    final newProduct = Product(
      id: DateTime.now().toString(),
      name: _nameController.text,
      price: double.parse(_priceController.text),
      image: _pickedImage!,
    );

    ref.read(productProvider.notifier).addProduct(newProduct);

    // Clear inputs
    _nameController.clear();
    _priceController.clear();
    _pickedImage = null;

    Navigator.of(context).pop(); // Close dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product added successfully!")),
    );
  }

  void _showAddProductDialog(WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Product"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Product Price"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick Image"),
            ),
            if (_pickedImage != null)
              Image.file(
                _pickedImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => _addProduct(ref),
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _deleteProduct(Product product, WidgetRef ref) {
    ref.read(productProvider.notifier).deleteProduct(product.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} removed from the list!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddProductDialog(ref),
          ),
        ],
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(product, ref),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
