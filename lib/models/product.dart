// Represents a product in MyanPOS.
//
// This model describes the basic information we need
// to identify and sell a product.
class Product {
  // Unique identifier for the product.
  final String id;

  // Product name displayed to the user.
  final String name;

  // Barcode used to identify the product.
  final String barcode;

  // Selling price of the product.
  final double price;

  // Current quantity available in inventory.
  final int stockQuantity;

  // Create a Product object with the required information.
  const Product({
    required this.id,
    required this.name,
    required this.barcode,
    required this.price,
    required this.stockQuantity,
  });
}