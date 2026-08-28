//import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';

import 'package:myanpos/database/app_database.dart';
import 'package:myanpos/database/repositories/product_repository.dart';
import 'package:myanpos/models/product.dart' as app;
void main() {
  // Create a fresh in-memory database for every test.
  //
  // This keeps the test isolated from the real local database.
  late AppDatabase database;
  late ProductRepository repository;

  setUp(() {
    // Create an SQLite database that exists only in memory.
    database = AppDatabase.forTesting(
      NativeDatabase.memory(),
    );

    // Create the repository using the test database.
    repository = ProductRepository(database);
  });

  tearDown(() async {
    // Close the database after every test.
    await database.close();
  });

  test('product can be inserted and retrieved', () async {
    // Create a sample product.
   // Create an application-level product.
    const product = app.Product(
      id: 'product-001',
      name: 'Coca Cola',
      barcode: '123456789',
      price: 1500,
      stockQuantity: 20,
    );

    // Insert the product through the repository.
    await repository.insertProduct(product);

    // Read all products from SQLite.
    final products = await repository.getAllProducts();

    // Verify that one product was stored.
    expect(products.length, 1);

    // Verify the stored product information.
    expect(products.first.name, 'Coca Cola');
    expect(products.first.barcode, '123456789');
    expect(products.first.price, 1500);
    expect(products.first.stockQuantity, 20);
  });
}