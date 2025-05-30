import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class WishlistService {
  static final WishlistService _instance = WishlistService._internal();
  factory WishlistService() => _instance;
  WishlistService._internal();

  Future<String?> _getUserId() async {
    return await SharedPrefsHelper.getUserId();
  }

  Future<List<Product>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = await _getUserId();
    if (userId == null) return [];

    final jsonString = prefs.getString('wishlist_$userId');
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Product.fromJson(e)).toList();
  }

  Future<void> _saveWishlist(String userId, List<Product> wishlist) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = wishlist.map((e) => e.toJson()).toList();
    prefs.setString('wishlist_$userId', json.encode(jsonList));
  }

  Future<void> addToWishlist(Product product) async {
    final userId = await _getUserId();
    if (userId == null) return;

    final wishlist = await getWishlist();
    final exists = wishlist.any((item) => item.id == product.id);
    if (!exists) {
      wishlist.add(product);
      await _saveWishlist(userId, wishlist);
    }
  }

  Future<void> removeFromWishlist(Product product) async {
    final userId = await _getUserId();
    if (userId == null) return;

    final wishlist = await getWishlist();
    wishlist.removeWhere((item) => item.id == product.id);
    await _saveWishlist(userId, wishlist);
  }

  Future<void> toggleWishlist(Product product) async {
    final userId = await _getUserId();
    if (userId == null) return;

    final wishlist = await getWishlist();
    final exists = wishlist.any((item) => item.id == product.id);

    if (exists) {
      wishlist.removeWhere((item) => item.id == product.id);
    } else {
      wishlist.add(product);
    }

    await _saveWishlist(userId, wishlist);
  }

  Future<bool> isInWishlist(Product product) async {
    final wishlist = await getWishlist();
    return wishlist.any((item) => item.id == product.id);
  }

  Future<void> clearWishlist() async {
    final userId = await _getUserId();
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('wishlist_$userId');
  }
}
