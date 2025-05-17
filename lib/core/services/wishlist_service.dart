import 'dart:developer';

import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

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
    log("Attempting to add product to wishlist:");
    log("${product.toJson()}");

    final wishlist = await SharedPrefsHelper.getWishlist();
    final exists = wishlist.any((item) => item.id == product.id);

    if (!exists) {
      wishlist.add(product);
      await SharedPrefsHelper.saveWishlist(wishlist);
      log("Product added and saved!");
    } else {
      log("Product already exists");
    }
  }

  static Future<void> removeFromWishlist(String productId) async {
    await SharedPrefsHelper.removeFromWishlist(productId);
    showToast("Removed from wishlist");
  }
}
