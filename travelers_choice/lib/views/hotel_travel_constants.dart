import '../models/cart.dart';
import '../models/category.dart';
import '../models/plane.dart';
import '../models/product.dart';
import '../models/tickets.dart';

class HotelTravelCache {
  static List<Category>? categories;
  static List<Product>? products;
  static List<Cart>? carts;
  static List<Tickets>? tickets;
  static List<Planes>? planes;
  // static List<Product>? carts;

  static bool isFirstTime = true;
}
