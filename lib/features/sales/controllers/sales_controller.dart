import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/app_database.dart';
import '../../../database/repositories/product_repository.dart';
import '../../../models/cart_item.dart';
import '../../../models/product.dart' as app;
import '../../../services/product_service.dart';

/// Provides the ProductService used by the sales feature.
///
/// The service is connected to the local Drift database.
final productServiceProvider = Provider<ProductService>((ref) {
  final database = AppDatabase();

  ref.onDispose(database.close);

  return ProductService(
    ProductRepository(database),
  );
});

/// State used by the Sales screen.
class SalesState {
  final List<app.Product> searchResults;
  final List<CartItem> cart;
  final bool isSearching;
  final String? errorMessage;

  const SalesState({
    this.searchResults = const [],
    this.cart = const [],
    this.isSearching = false,
    this.errorMessage,
  });

  /// Calculate the total price of all items in the cart.
  double get cartTotal {
    return cart.fold(
      0,
      (total, item) => total + item.totalPrice,
    );
  }

  /// Create a new state while keeping unchanged values.
  SalesState copyWith({
    List<app.Product>? searchResults,
    List<CartItem>? cart,
    bool? isSearching,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SalesState(
      searchResults: searchResults ?? this.searchResults,
      cart: cart ?? this.cart,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

/// Controls search and cart operations for the Sales screen.
class SalesController extends Notifier<SalesState> {
  late final ProductService _productService;

  @override
  SalesState build() {
    _productService = ref.read(productServiceProvider);

    return const SalesState();
  }

  /// Search products by name or barcode.
  ///
  /// This currently searches the local database.
  /// Later, online search can be added without changing the UI.
  Future<void> searchProducts(String query) async {
    final searchText = query.trim().toLowerCase();

    // Empty search -> clear results.
    if (searchText.isEmpty) {
      state = state.copyWith(
        searchResults: [],
        isSearching: false,
        clearError: true,
      );

      return;
    }

    state = state.copyWith(
      isSearching: true,
      clearError: true,
    );

    try {
      // Get products from local database.
      final products = await _productService.getAllProducts();

      final results = products.where((product) {
        final nameMatches = product.name
            .toLowerCase()
            .contains(searchText);

        final barcodeMatches = product.barcode
            .toLowerCase()
            .contains(searchText);

        return nameMatches || barcodeMatches;
      }).toList();

      state = state.copyWith(
        searchResults: results,
        isSearching: false,
      );
    } catch (e) {
      state = state.copyWith(
        searchResults: [],
        isSearching: false,
        errorMessage: 'Failed to search products.',
      );
    }
  }

  /// Add a product to the cart.
  ///
  /// If the product already exists in the cart,
  /// increase its quantity instead of creating another item.
  void addToCart(app.Product product) {
    final cart = List<CartItem>.from(state.cart);

    final existingIndex = cart.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      cart[existingIndex].quantity++;
    } else {
      cart.add(
        CartItem(
          product: product,
        ),
      );
    }

    state = state.copyWith(
      cart: cart,
      clearError: true,
    );
  }

  /// Increase product quantity.
  void increaseQuantity(CartItem cartItem) {
    final cart = List<CartItem>.from(state.cart);

    final index = cart.indexOf(cartItem);

    if (index == -1) return;

    cart[index].quantity++;

    state = state.copyWith(cart: cart);
  }

  /// Decrease product quantity.
  ///
  /// Quantity will never go below 1.
  void decreaseQuantity(CartItem cartItem) {
    final cart = List<CartItem>.from(state.cart);

    final index = cart.indexOf(cartItem);

    if (index == -1) return;

    if (cart[index].quantity > 1) {
      cart[index].quantity--;
    }

    state = state.copyWith(cart: cart);
  }

  /// Remove an item completely from the cart.
  void removeFromCart(CartItem cartItem) {
    final cart = List<CartItem>.from(state.cart);

    cart.remove(cartItem);

    state = state.copyWith(cart: cart);
  }

  /// Clear the entire cart.
  void clearCart() {
    state = state.copyWith(
      cart: [],
    );
  }
}

/// Riverpod provider for the SalesController.
final salesControllerProvider =
    NotifierProvider<SalesController, SalesState>(
  SalesController.new,
);
