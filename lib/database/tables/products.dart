import 'package:drift/drift.dart';

// Products table.
//
// This table stores the products that can be sold
// through MyanPOS.
class Products extends Table {
  // Unique product ID.
  TextColumn get id => text()();

  // Product name.
  TextColumn get name => text()();

  // Barcode used for searching products.
  TextColumn get barcode => text()();

  // Selling price.
  RealColumn get price => real()();

  // Current inventory quantity.
  IntColumn get stockQuantity => integer()();

  // Product ID must be unique.
  @override
  Set<Column> get primaryKey => {id};
}