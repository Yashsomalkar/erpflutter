import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_models/cart_provider.dart';

class VendorScreen extends ConsumerStatefulWidget {
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends ConsumerState<VendorScreen> {
  final List<String> _categories = ["Catering", "Florist", "Decoration", "Lighting"];
  String _selectedCategory = "Catering"; // Default category

  // Dummy product data
  final List<Product> _allProducts = [
    Product(
      id: "1",
      name: "Buffet Service",
      price: 199.99,
      category: "Catering",
      image: "https://media.istockphoto.com/id/1249206724/photo/banquet-catering-buffet-food.jpg?s=2048x2048&w=is&k=20&c=3b4UxXc6HF6sPsRdBbpG2OpwnD-llUDaOwt2RLooSGI=",
    ),
    Product(
      id: "2",
      name: "Event Catering",
      price: 299.99,
      category: "Catering",
      image: "https://cdn.pixabay.com/photo/2019/09/28/17/25/food-4511335_1280.jpg",
    ),
    Product(
      id: "3",
      name: "Rose Bouquet",
      price: 49.99,
      category: "Florist",
      image: "https://cdn.pixabay.com/photo/2016/11/23/17/56/flowers-1854075_1280.jpg",
    ),
    Product(
      id: "4",
      name: "Wedding Flowers",
      price: 89.99,
      category: "Florist",
      image: "https://cdn.pixabay.com/photo/2018/03/16/12/29/flowers-3231099_1280.jpg",
    ),
    Product(
        id: "5",
        name: "Stage Decoration",
        price: 399.99,
        image: "https://media.istockphoto.com/id/1130344289/photo/indian-wedding-stage-decorations-with-colorful-flowers.jpg?s=2048x2048&w=is&k=20&c=ykwv_a7uBDkkMVb9oIlW_ckjvdLEBnIAbj4ji0I4dUo=", category: 'Decoration'),
    Product(
        id: "6",
        name: "Balloon Decoration",
        price: 99.99,
        image: "https://media.istockphoto.com/id/1405876768/photo/decoration-for-a-childrens-party.jpg?s=2048x2048&w=is&k=20&c=Z9Dgrjkow-_cjF6kSDwtE2oCaWjbwbdh3TnaOQp4LFI=", category: 'Decoration'),
    Product(
        id: "7",
        name: "Fairy Lights",
        price: 29.99,
        image: "https://media.istockphoto.com/id/1359056867/photo/cable-of-string-led-lights-on-tree-in-the-garden-at-night-time-used-for-decorating-for-beauty.jpg?s=2048x2048&w=is&k=20&c=xXL9Zg20H9XOhH8NITWVAbHzeAQkgwPNrWKC_ofJ3wM=", category: 'Lighting'),
    Product(
        id: "8",
        name: "Spotlights",
        price: 59.99,
        image: "https://media.istockphoto.com/id/1374650174/vector/studio-background-with-realistic-podium-spotlight.jpg?s=2048x2048&w=is&k=20&c=5drMTIUdZMYqPuuI3G_LhryG2oaR_d-VumETaqwHRH0=", category: 'Lighting'),
    Product(
      id: "9",
      name: "Canopy Tent",
      price: 499.99,
      category: "Catering",
      image: "https://media.gettyimages.com/id/1397656573/photo/birthday-tent.jpg?s=1024x1024&w=gi&k=20&c=nin5ljWdEtO6Uo9Ued_Q2bWlZjmYk1QshyaF6dN9xGk=",
    ),
    Product(
      id: "10",
      name: "Live Cooking Station",
      price: 599.99,
      category: "Catering",
      image: "https://media.gettyimages.com/id/1225060437/photo/making-bento-in-japan.jpg?s=1024x1024&w=gi&k=20&c=inQMIEFOBPj34ISnkzAo9Fb2wuvf-ivIEgl4lVqapnU=",
    ),
    Product(
      id: "11",
      name: "Tulip Bouquet",
      price: 69.99,
      category: "Florist",
      image: "https://media.gettyimages.com/id/1200610088/photo/woman-making-a-bouquet-of-tulips.jpg?s=1024x1024&w=gi&k=20&c=uZk6fxRWPfF7mZQzS8yIuse6WifUfe9WZhhRK8gaS5I=",
    ),
    Product(
      id: "12",
      name: "Orchid Centerpiece",
      price: 129.99,
      category: "Florist",
      image: "https://media.gettyimages.com/id/92572487/photo/centerpiece-of-orchids-in-vase.jpg?s=1024x1024&w=gi&k=20&c=cNcP4MSXE7hxRksPBjJkvQYLIb4LJVkoQP1TpaVFkgw=",
    ),
    Product(
      id: "13",
      name: "Ceiling Drapes",
      price: 499.99,
      category: "Decoration",
      image: "https://i.pinimg.com/736x/9f/41/43/9f4143476cd1ccf6f3b219d83f80bd99.jpg",
    ),
    Product(
      id: "14",
      name: "LED Backdrop",
      price: 699.99,
      category: "Decoration",
      image: "https://i.pinimg.com/736x/a8/1e/1f/a81e1fd8c1e93ff9488dcc5c3585280d.jpg",
    ),
    Product(
      id: "15",
      name: "Chandeliers",
      price: 199.99,
      category: "Lighting",
      image: "https://media.gettyimages.com/id/120170463/photo/series-of-well-lit-crystal-chandeliers.jpg?s=1024x1024&w=gi&k=20&c=v1Zp-WOBSPkhYsTYMoh1nh-QFUnnI1NNqRDEEb79E_0=",
    ),
    Product(
      id: "16",
      name: "Event String Lights",
      price: 39.99,
      category: "Lighting",
      image: "https://media.gettyimages.com/id/1300384615/photo/string-light-bulbs-at-sunset.jpg?s=1024x1024&w=gi&k=20&c=GmtLk8CCbCW-uIzOUqos1T0EJ6ePErwZxaLoHcVJqYA=",
    ),
  ];

  // Local state for the quantities (sync with Riverpod)
  late Map<String, int> _quantities;

  @override
  void initState() {
    super.initState();
    _quantities = {}; // Initialize quantities for all products
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cart = ref.watch(cartProvider);

    // Filter products by the selected category
    final List<Product> currentProducts =
    _allProducts.where((product) => product.category == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          value: _selectedCategory,
          onChanged: (newValue) {
            setState(() {
              _selectedCategory = newValue!;
            });
          },
          items: _categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          dropdownColor: Colors.blue,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: currentProducts.length,
          itemBuilder: (context, index) {
            final product = currentProducts[index];
            final inCart = cart.firstWhere((item) => item.id == product.id, orElse: () => product);

            return ProductCard(
              product: product,
              inCartQuantity: _quantities[product.id] ?? inCart.quantity,
              onAdd: () {
                cartNotifier.addProduct(product);
                setState(() {
                  _quantities[product.id] = (_quantities[product.id] ?? 0) + 1;
                });
              },
              onRemove: () {
                if (_quantities[product.id] != null && _quantities[product.id]! > 0) {
                  cartNotifier.removeProduct(product.id);
                  setState(() {
                    _quantities[product.id] = (_quantities[product.id]! - 1).clamp(0, double.infinity).toInt();
                  });
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int inCartQuantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductCard({
    Key? key,
    required this.product,
    required this.inCartQuantity,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("\$${product.price}", style: const TextStyle(fontSize: 14, color: Colors.green)),
                const SizedBox(height: 5),
                inCartQuantity > 0
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onRemove,
                    ),
                    Text("$inCartQuantity"),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onAdd,
                    ),
                  ],
                )
                    : ElevatedButton(
                  onPressed: onAdd,
                  child: const Text("Add to Cart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
