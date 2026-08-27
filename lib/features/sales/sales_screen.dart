import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../services/product_service.dart';

// Sales screen.
//
// This screen allows the user to search for products
// before adding them to the sales cart.
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  // Controller for reading the search field.
  final TextEditingController _searchController = TextEditingController();

  // Product service provides product data.
  final ProductService _productService = ProductService();

  // Products currently displayed after searching.
  List<Product> _searchResults = [];

  @override
  void dispose() {
    // Release the text controller when the screen is destroyed.
    _searchController.dispose();
    super.dispose();
  }

  // Search products by name or barcode.
  void _searchProducts(String query) {
    // Remove unnecessary spaces and make the search case-insensitive.
    final searchText = query.trim().toLowerCase();

    // If the search field is empty, show no results.
    if (searchText.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    // Get all products from the product service.
    final products = _productService.getAllProducts();

    // Find products whose name or barcode matches the search text.
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

              // Search whenever the user changes the text.
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
                          onTap: () {
                            // We will add the product to the cart
                            // in the next task.
                          },
                        );
                      },
                    ),
            ),
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

        // Called when the product is selected.
        onTap: onTap,
      ),
    );
  }
}