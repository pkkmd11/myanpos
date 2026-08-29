import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'tables/products.dart';

part 'app_database.g.dart';

// Main local database for MyanPOS.
//
// The database connection is platform-specific:
// - Windows / Android / iOS / Linux / macOS -> SQLite
// - Web -> SQLite compiled to WebAssembly
@DriftDatabase(
  tables: [
    Products,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  // Constructor used by automated tests.
  AppDatabase.forTesting(super.connection);

  @override
  int get schemaVersion => 1;

  // Insert a new product.
  Future<void> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  // Get all products.
  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }
}

