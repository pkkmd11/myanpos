import 'package:flutter/material.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import 'widgets/cart_item_tile.dart';

// Sales screen.
//
// This screen is responsible for searching products
// and managing the current sales cart.
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

// State of the SalesScreen.
class _SalesScreenState extends State<SalesScreen> {
  // Controller used to read the product search field.
  final TextEditingController _searchController = TextEditingController();

  // Service used to get product data.
  final ProductService _productService = ProductService();

  // Products currently displayed as search results.
  List<Product> _searchResults = [];

  // Products currently added to the sales cart.
  //
  // Each CartItem contains a Product and its quantity.
  final List<CartItem> _cart = [];

  @override
  void dispose() {
    // Release the search controller when the screen is destroyed.
    _searchController.dispose();

    super.dispose();
  }

  // Search products by name or barcode.
  void _searchProducts(String query) {
    // Remove extra spaces and make the search case-insensitive.
    final searchText = query.trim().toLowerCase();

    // Clear search results when the search field is empty.
    if (searchText.isEmpty) {
      setState(() {
        _searchResults = [];
      });

      return;
    }

    // Get all available products.
    final products = _productService.getAllProducts();

    // Find products matching the name or barcode.
    final results = products.where((product) {
      final nameMatches = product.name.toLowerCase().contains(searchText);
      final barcodeMatches = product.barcode.contains(searchText);

      return nameMatches || barcodeMatches;
    }).toList();

    // Update the UI with the matching products.
    setState(() {
      _searchResults = results;
    });
  }

  // Calculate the total price of all products in the cart.
  //
  // Example:
  // Coca Cola = 1,500 MMK × 2 = 3,000 MMK
  // Pepsi     = 1,500 MMK × 1 = 1,500 MMK
  // Total     = 4,500 MMK
  double _calculateCartTotal() {
    return _cart.fold(
      0,
      (total, cartItem) => total + cartItem.totalPrice,
    );
  }

  // Add a product to the cart.
  void _addToCart(Product product) {
    setState(() {
      // Check whether this product is already in the cart.
      final existingIndex = _cart.indexWhere(
        (cartItem) => cartItem.product.id == product.id,
      );

      if (existingIndex >= 0) {
        // If the product already exists, increase its quantity.
        _cart[existingIndex].quantity++;
      } else {
        // Otherwise, create a new cart item with quantity 1.
        _cart.add(
          CartItem(
            product: product,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar.
      appBar: AppBar(
        title: const Text('New Sale'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product search field.
            TextField(
              controller: _searchController,

              // Search products whenever the text changes.
              onChanged: _searchProducts,

              decoration: InputDecoration(
                labelText: 'Search product',
                hintText: 'Enter product name or barcode',
                prefixIcon: const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Display search results.
            Expanded(
              child: _searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];

                        return _ProductResultCard(
                          product: product,

                          // Add the selected product to the cart.
                          onTap: () {
                            _addToCart(product);
                          },
                        );
                      },
                    ),
            ),

            // Show the cart only when it contains products.
            if (_cart.isNotEmpty) ...[
              const SizedBox(height: 16),

              // Cart section.
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cart heading.
                      const Text(
                        'Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Display every item in the cart.
                     // Display every item in the cart.
                    for (final cartItem in _cart)
                      CartItemTile(
                        cartItem: cartItem,

                        // Decrease the quantity.
                        onDecrease: () {
                          setState(() {
                            if (cartItem.quantity > 1) {
                              cartItem.quantity--;
                            }
                          });
                        },

                        // Increase the quantity.
                        onIncrease: () {
                          setState(() {
                            cartItem.quantity++;
                          });
                        },

                        // Remove the item from the cart.
                        onRemove: () {
                          setState(() {
                            _cart.remove(cartItem);
                          });
                        },
                      ),

                      const Divider(),

                      // Grand total.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Total label.
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // Calculate and display the cart total.
                          Text(
                            '${_calculateCartTotal().toStringAsFixed(0)} MMK',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Displays a product returned by the search.
class _ProductResultCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductResultCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // Product icon.
        leading: const Icon(Icons.inventory_2),

        // Product name.
        title: Text(product.name),

        // Barcode and stock information.
        subtitle: Text(
          'Barcode: ${product.barcode} • Stock: ${product.stockQuantity}',
        ),

        // Product selling price.
        trailing: Text(
          '${product.price.toStringAsFixed(0)} MMK',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        // Add product to cart when selected.
        onTap: onTap,
      ),
    );
  }
}