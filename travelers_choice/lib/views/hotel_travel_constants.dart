import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/tickets.dart';

class HotelTravelCache {
  static List<Category>? categories;
  static List<Product>? products;
  static List<Cart>? carts;
  static List<Tickets>? tickets;
  // static List<Product>? carts;

  static bool isFirstTime = true;
}
