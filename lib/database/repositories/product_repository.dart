import '../app_database.dart';

// Handles product-related database operations.
//
// The repository keeps database code away from the UI.
// This makes the application easier to maintain as it grows.
class ProductRepository {
  final AppDatabase database;

  ProductRepository(this.database);

  // Get all products stored in the local database.
  Future<List<Product>> getAllProducts() {
    return database.select(database.products).get();
  }

  // Insert a product into the local database.
  Future<void> insertProduct(ProductsCompanion product) {
    return database.into(database.products).insert(product);
  }
}