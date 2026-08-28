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
}