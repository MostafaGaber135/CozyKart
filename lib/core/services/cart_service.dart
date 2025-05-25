import 'dart:developer';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class CartService {
  static Future<List<Product>> getCart() async {
    final token = await SharedPrefsHelper.getToken();

    try {
      final response = await DioHelper.getData(
        url: 'http://192.168.1.7:3000/carts',
        headers: {'Authorization': 'Bearer $token'},
      );

      final data = response.data['cart'];
      log("CART RESPONSE => ${response.data}");

      if (data == null || data is! List) {
        log('Cart is empty or invalid.');
        return [];
      }

      return List<Product>.from(
        data.map((item) {
          final rawProduct = item['productId'];
          final product = Product.fromJson(rawProduct);
          product.quantity = item['quantity'] ?? 1;
          return product;
        }),
      );
    } catch (e) {
      log('Error fetching cart: $e');
      return [];
    }
  }

  static Future<bool> addToCart(String productId, int quantity) async {
    final token = await SharedPrefsHelper.getToken();
    try {
      await DioHelper.postData(
        url: 'http://192.168.1.7:3000/carts',
        data: {'productId': productId, 'quantity': quantity},
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      return true;
    } catch (e) {
      log('Error adding to cart: $e');
      return false;
    }
  }

  static Future<bool> removeFromCart(String productId) async {
    final token = await SharedPrefsHelper.getToken();
    try {
      await DioHelper.deleteData(
        url: 'http://192.168.1.7:3000/carts/$productId',
        headers: {'Authorization': 'Bearer $token'},
      );
      return true;
    } catch (e) {
      log('Error removing from cart: $e');
      return false;
    }
  }
}
