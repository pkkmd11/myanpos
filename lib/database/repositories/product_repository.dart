import '../../models/product.dart' as app;
import '../app_database.dart';
import '../mappers/product_mapper.dart';

// Handles product-related database operations.
//
// The UI works with application Product objects.
// Drift/database objects stay inside the database layer.
class ProductRepository {
  final AppDatabase database;

  ProductRepository(this.database);

  // Get all products from the local database
  // and convert them into application Product objects.
  Future<List<app.Product>> getAllProducts() async {
    // Read products from SQLite.
    final databaseProducts = await database.select(database.products).get();

    // Convert database products to application products.
    return databaseProducts
        .map(ProductMapper.toApplicationProduct)
        .toList();
  }

  // Insert a product into the local database.
  Future<void> insertProduct(app.Product product) {
    // Convert the application Product into a Drift Companion.
    final databaseProduct = ProductsCompanion.insert(
      id: product.id,
      name: product.name,
      barcode: product.barcode,
      price: product.price,
      stockQuantity: product.stockQuantity,
    );

    // Save the product to SQLite.
    return database.into(database.products).insert(databaseProduct);
  }
}