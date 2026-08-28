import '../../models/product.dart' as app;
import '../app_database.dart';

// Converts database products into application products.
//
// This keeps Drift/database-specific types away from the UI.
class ProductMapper {
  // Convert a Drift database Product into our application Product.
  static app.Product toApplicationProduct(Product databaseProduct) {
    return app.Product(
      id: databaseProduct.id,
      name: databaseProduct.name,
      barcode: databaseProduct.barcode,
      price: databaseProduct.price,
      stockQuantity: databaseProduct.stockQuantity,
    );
  }
}