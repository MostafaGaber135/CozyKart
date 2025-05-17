import 'dart:convert';
import 'dart:developer';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    await _instance.setString('token', token);
    log("Saved token: $token");
  }

  static Future<String?> getToken() async {
    return _instance.getString('token');
  }

  static Future<void> clearToken() async {
    await _instance.remove('token');
  }

  static Future<void> saveUserId(String userId) async {
    await _instance.setString("userId", userId);
    log("Saved userId: $userId");
  }

  static Future<String?> getUserId() async {
    return _instance.getString("userId");
  }

  static Future<void> removeUserId() async {
    await _instance.remove("userId");
  }

  static void setBool(String key, bool value) {
    _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  static Future<void> saveCart(List<Product> cartItems) async {
    final userId = await getUserId();
    if (userId == null) {
      log("Can't save cart: userId is null");
      return;
    }

    final cartJson =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    await _instance.setStringList('cart_$userId', cartJson);
    log("Cart saved under key: cart_$userId with ${cartItems.length} items");
  }

  static Future<List<Product>> getCart() async {
    final userId = await getUserId();
    if (userId == null) return [];

    final cartJson = _instance.getStringList('cart_$userId') ?? [];
    return cartJson.map((item) => Product.fromJson(jsonDecode(item))).toList();
  }

  static Future<void> removeFromCart(String productId) async {
    final cart = await getCart();
    cart.removeWhere((item) => item.id == productId);
    await saveCart(cart);
  }

  static Future<void> clearCart() async {
    final userId = await getUserId();
    if (userId == null) return;

    await _instance.remove('cart_$userId');
  }

  static Future<void> saveWishlist(List<Product> wishlistItems) async {
    final userId = await getUserId();
    if (userId == null) {
      log("Can't save wishlist: userId is null");
      return;
    }

    final wishlistJson =
        wishlistItems.map((item) => jsonEncode(item.toJson())).toList();

    log("Saving wishlist for userId: $userId");
    log("Wishlist items count: ${wishlistItems.length}");

    for (var item in wishlistItems) {
      log("${item.toJson()}");
    }

    await _instance.setStringList('wishlist_$userId', wishlistJson);

    final keys = _instance.getKeys();
    log("All SharedPreferences keys: $keys");
    log("wishlist_$userId = ${_instance.getStringList('wishlist_$userId')}");
  }

  static Future<List<Product>> getWishlist() async {
    final userId = await getUserId();
    if (userId == null) {
      log("Can't load wishlist: userId is null");
      return [];
    }

    final wishlistJson = _instance.getStringList('wishlist_$userId') ?? [];
    return wishlistJson
        .map((item) => Product.fromJson(jsonDecode(item)))
        .toList();
  }

  static Future<void> removeFromWishlist(String productId) async {
    final userId = await getUserId();
    if (userId == null) return;

    final list = _instance.getStringList('wishlist_$userId') ?? [];
    list.removeWhere((item) => jsonDecode(item)['id'] == productId);
    await _instance.setStringList('wishlist_$userId', list);
  }
}
