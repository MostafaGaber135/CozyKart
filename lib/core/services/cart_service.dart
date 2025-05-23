import 'dart:developer';

import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/core/network/dio_helper.dart';

Future<void> syncCartToBackend() async {
  final cartItems = await SharedPrefsHelper.getCart();
  final userId = await SharedPrefsHelper.getUserId();
  final token = await SharedPrefsHelper.getToken();

  for (var item in cartItems) {
    try {
      await DioHelper.postData(
        url: "https://furniture-backend-production-8726.up.railway.app/cart",
        data: {
          "userId": userId,
          "productId": item.id,
          "quantity": item.quantity,
        },
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
    } catch (e) {
      log("Failed to sync item to cart: $e");
    }
  }

  log("Cart synced to backend");
}
