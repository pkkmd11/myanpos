import 'package:flutter/material.dart';

import '../../../models/cart_item.dart';

// Displays one item inside the sales cart.
//
// This widget is responsible only for displaying and
// modifying a single CartItem.
class CartItemTile extends StatelessWidget {
  // The cart item displayed by this widget.
  final CartItem cartItem;

  // Called when the user wants to decrease the quantity.
  final VoidCallback onDecrease;

  // Called when the user wants to increase the quantity.
  final VoidCallback onIncrease;

  // Called when the user wants to remove the item.
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.cartItem,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      // Product name.
      title: Text(cartItem.product.name),

      // Quantity controls.
      subtitle: Row(
        children: [
          // Decrease quantity.
          IconButton(
            onPressed: onDecrease,
            icon: const Icon(Icons.remove),
          ),

          // Current quantity.
          Text(
            '${cartItem.quantity}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Increase quantity.
          IconButton(
            onPressed: onIncrease,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      // Price and remove button.
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total price for this item.
          Text(
            '${cartItem.totalPrice.toStringAsFixed(0)} MMK',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 8),

          // Remove item from the cart.
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Remove from cart',
          ),
        ],
      ),
    );
  }
}