import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';

class HotelTravelCache {
  static List<Category>? categories;
  static List<Product>? products;
  static List<Cart>? carts;
  // static List<Product>? carts;

  static bool isFirstTime = true;
}
