import 'package:flutter/material.dart';

// Sales screen.
//
// This screen will eventually handle the complete checkout process.
// For now, we are building the basic product search interface.
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  // Controller used to read the text entered into the search field.
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Release the controller when this screen is removed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar.
      appBar: AppBar(
        title: const Text('New Sale'),
      ),

      // Main sales screen content.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product search field.
            TextField(
              controller: _searchController,

              // Search field configuration.
              decoration: InputDecoration(
                labelText: 'Search product',
                hintText: 'Enter product name or barcode',

                // Search icon shown at the beginning of the field.
                prefixIcon: const Icon(Icons.search),

                // Border around the search field.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Temporary empty-cart message.
            const Expanded(
              child: Center(
                child: Text(
                  'No products added',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}