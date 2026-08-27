import 'package:flutter_test/flutter_test.dart';

// Import the Product model that we want to test.
import 'package:myanpos/models/product.dart';

void main() {
  // Test that a Product object stores the correct information.
  test('Product model stores product information correctly', () {
    // Create a sample product for testing.
    const product = Product(
      id: 'product-001',
      name: 'Coca Cola',
      barcode: '123456789',
      price: 1500,
      stockQuantity: 20,
    );

    // Verify the product ID.
    expect(product.id, 'product-001');

    // Verify the product name.
    expect(product.name, 'Coca Cola');

    // Verify the barcode.
    expect(product.barcode, '123456789');

    // Verify the selling price.
    expect(product.price, 1500);

    // Verify the available stock quantity.
    expect(product.stockQuantity, 20);
  });
}