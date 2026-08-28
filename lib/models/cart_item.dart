import 'product.dart';
// Represents one product inside the sales cart.
//
// A Product describes the product itself.
// A CartItem describes that product together with
// the quantity selected for the current sale.
class CartItem {
  // The product being added to the cart.
  final Product product;

  // Number of units selected by the customer.
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  // Calculate the total price for this cart item.
  //
  // Example:
  // Product price = 1,500 MMK
  // Quantity = 3
  // Item total = 4,500 MMK
  double get totalPrice => product.price * quantity;
}