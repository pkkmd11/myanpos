import '../models/product.dart';

// Provides product data to the application.
//
// For now, this service uses temporary in-memory data.
// Later, we will replace this with the local database
// and Supabase data source.
class ProductService {
  // Temporary sample products.
  //
  // These products are only used while we are building
  // and testing the POS interface.
  final List<Product> _products = [
    const Product(
      id: 'product-001',
      name: 'Coca Cola',
      barcode: '123456789',
      price: 1500,
      stockQuantity: 20,
    ),
    const Product(
      id: 'product-002',
      name: 'Pepsi',
      barcode: '987654321',
      price: 1500,
      stockQuantity: 15,
    ),
    const Product(
      id: 'product-003',
      name: 'Mineral Water',
      barcode: '555555555',
      price: 500,
      stockQuantity: 50,
    ),
  ];

  // Return all available products.
  List<Product> getAllProducts() {
    return List.unmodifiable(_products);
  }
}