import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/products.dart';
part 'app_database.g.dart';

// Main local database for MyanPOS.
//
// Drift manages the SQLite database underneath.
// We will add tables such as products and sales later.
@DriftDatabase(
  tables: [
    Products,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  // Constructor used by automated tests.
  //
  // This allows tests to use an in-memory SQLite database
  // without touching the user's real database.
  AppDatabase.forTesting(super.connection);

  // Database schema version.
  //
  // Increase this number when we make database schema changes.
  @override
  int get schemaVersion => 1;
  // Insert a new product into the local database.
  Future<void> insertProduct(ProductsCompanion product) {
    return into(products).insert(product);
  }

  // Get all products from the local database.
  Future<List<Product>> getAllProducts() {
    return select(products).get();
  }
}

// Open the SQLite database connection.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Get the application's database directory.
    final directory = await getApplicationDocumentsDirectory();

    // Create the full database file path.
    final file = File(
      p.join(directory.path, 'myanpos.sqlite'),
    );

    // Open the SQLite database in the background.
    return NativeDatabase.createInBackground(file);
  });
}