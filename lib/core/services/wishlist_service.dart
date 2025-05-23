import 'dart:developer';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/features/shop/data/models/product_model.dart';

class WishlistService {
  static Future<List<Product>> getWishlist() async {
    final userId = await SharedPrefsHelper.getUserId();
    log("Current userId: $userId");

    final items = await SharedPrefsHelper.getWishlist();
    log("Loaded wishlist: ${items.length}");

    for (var item in items) {
      log("WISHLIST ITEM: ${item.toJson()}");
    }

    return items;
  }

  static Future<void> addToWishlist(Product product) async {
    final wishlist = await getWishlist();
    wishlist.add(product);
    await SharedPrefsHelper.saveWishlist(wishlist);
  }

  static Future<void> removeFromWishlist(String productId) async {
    final wishlist = await getWishlist();
    wishlist.removeWhere((p) => p.id == productId);
    await SharedPrefsHelper.saveWishlist(wishlist);
  }
}
