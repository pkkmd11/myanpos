import '../database/repositories/product_repository.dart';
import '../models/product.dart';

// Provides product data to the application.
//
// The service hides the database details from the UI.
class ProductService {
  // Repository used to access local product data.
  final ProductRepository repository;

  ProductService(this.repository);

  // Get all products from the local database.
  Future<List<Product>> getAllProducts() {
    return repository.getAllProducts();
  }

  // Add a new product to the local database.
  Future<void> addProduct(Product product) {
    return repository.insertProduct(product);
  }
  // Add sample products when the database is empty.
//
// This is temporary seed data for development.
// Later, products will be created through the POS UI.
  Future<void> seedSampleProducts() async {
    // Check whether products already exist.
    final existingProducts = await repository.getAllProducts();

    // Do not insert duplicates.
    if (existingProducts.isNotEmpty) {
      return;
    }

    // Sample product 1.
    await addProduct(
      const Product(
        id: 'product-001',
        name: 'Coca Cola',
        barcode: '123456789',
        price: 1500,
        stockQuantity: 20,
      ),
    );

    // Sample product 2.
    await addProduct(
      const Product(
        id: 'product-002',
        name: 'Pepsi',
        barcode: '987654321',
        price: 1500,
        stockQuantity: 15,
      ),
    );

    // Sample product 3.
    await addProduct(
      const Product(
        id: 'product-003',
        name: 'Mineral Water',
        barcode: '555555555',
        price: 1000,
        stockQuantity: 30,
      ),
    );
  }
}