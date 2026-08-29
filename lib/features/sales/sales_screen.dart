import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/cart_item.dart';
import '../../models/product.dart' as app;
import 'controllers/sales_controller.dart';
import 'widgets/cart_item_tile.dart';

/// Sales screen.
///
/// The screen is responsible only for displaying the UI.
/// Search and cart logic are handled by SalesController.
class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the current sales state.
    final salesState = ref.watch(salesControllerProvider);

    // Get the controller without rebuilding the screen.
    final controller =
        ref.read(salesControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --------------------------------------------------
            // Product Search
            // --------------------------------------------------
            TextField(
              controller: _searchController,

              // Search whenever the user types.
              onChanged: controller.searchProducts,

              decoration: InputDecoration(
                labelText: 'Search product',
                hintText: 'Enter product name or barcode',
                prefixIcon: const Icon(Icons.search),

                // Clear search button.
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();

                          controller.searchProducts('');
                          setState(() {});
                        },
                      )
                    : null,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --------------------------------------------------
            // Search Results
            // --------------------------------------------------
            Expanded(
              child: _buildSearchResults(
                context,
                salesState,
                controller,
              ),
            ),

            // --------------------------------------------------
            // Cart
            // --------------------------------------------------
            if (salesState.cart.isNotEmpty)
              _buildCart(
                context,
                salesState,
                controller,
              ),
          ],
        ),
      ),
    );
  }

  /// Build the product search result section.
  Widget _buildSearchResults(
    BuildContext context,
    SalesState state,
    SalesController controller,
  ) {
    // Show loading indicator while searching.
    if (state.isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Show error message.
    if (state.errorMessage != null) {
      return Center(
        child: Text(
          state.errorMessage!,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }

    // No search results.
    if (state.searchResults.isEmpty) {
      return const Center(
        child: Text(
          'Search for a product',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.searchResults.length,
      itemBuilder: (context, index) {
        final product = state.searchResults[index];

        return _ProductResultCard(
          product: product,

          onTap: () {
            controller.addToCart(product);
          },
        );
      },
    );
  }

  /// Build the shopping cart section.
  Widget _buildCart(
    BuildContext context,
    SalesState state,
    SalesController controller,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------------------------
            // Cart Header
            // --------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Clear cart button.
                TextButton(
                  onPressed: controller.clearCart,
                  child: const Text('Clear'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // --------------------------------------------------
            // Cart Items
            // --------------------------------------------------
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.cart.length,
                itemBuilder: (context, index) {
                  final cartItem = state.cart[index];

                  return CartItemTile(
                    cartItem: cartItem,

                    // Decrease quantity.
                    onDecrease: () {
                      controller.decreaseQuantity(
                        cartItem,
                      );
                    },

                    // Increase quantity.
                    onIncrease: () {
                      controller.increaseQuantity(
                        cartItem,
                      );
                    },

                    // Remove product.
                    onRemove: () {
                      controller.removeFromCart(
                        cartItem,
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(),

            // --------------------------------------------------
            // Grand Total
            // --------------------------------------------------
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${state.cartTotal.toStringAsFixed(0)} MMK',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // --------------------------------------------------
            // Checkout Button
            // --------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Checkout will be implemented next.
                },
                child: const Text(
                  'Checkout',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays one product from the search results.
class _ProductResultCard extends StatelessWidget {
  final app.Product product;
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
        leading: const Icon(
          Icons.inventory_2,
        ),

        // Product name.
        title: Text(
          product.name,
        ),

        // Barcode and stock.
        subtitle: Text(
          'Barcode: ${product.barcode} '
          '• Stock: ${product.stockQuantity}',
        ),

        // Selling price.
        trailing: Text(
          '${product.price.toStringAsFixed(0)} MMK',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        // Add product to cart.
        onTap: onTap,
      ),
    );
  }
}

