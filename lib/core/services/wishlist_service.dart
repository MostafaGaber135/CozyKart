import 'dart:developer';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class WishlistService {
  static Future<List<Product>> getWishlist() async {
    final token = await SharedPrefsHelper.getToken();
    try {
      final response = await DioHelper.getData(
        url: 'http://192.168.1.7:3000/wishlist',
        headers: {'Authorization': 'Bearer $token'},
      );

      final data = response.data['wishlist'];
      if (data == null || data is! List) return [];

      return List<Product>.from(data.map((item) => Product.fromJson(item)));
    } catch (e) {
      log('Error fetching wishlist: $e');
      return [];
    }
  }

  static Future<bool> addToWishlist(String productId) async {
    final token = await SharedPrefsHelper.getToken();
    try {
      await DioHelper.postData(
        url: 'http://192.168.1.7:3000/wishlist',
        data: {'productId': productId},
        headers: {'Authorization': 'Bearer $token'},
      );
      return true;
    } catch (e) {
      log('Error adding to wishlist: $e');
      return false;
    }
  }

  static Future<bool> removeFromWishlist(String productId) async {
    final token = await SharedPrefsHelper.getToken();
    try {
      await DioHelper.deleteData(
        url: 'http://192.168.1.7:3000/wishlist/$productId',
        headers: {'Authorization': 'Bearer $token'},
      );
      return true;
    } catch (e) {
      log('Error removing from wishlist: $e');
      return false;
    }
  }
}
