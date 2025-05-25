import 'dart:developer';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class OrderService {
  static Future<bool> createOrder({
    required List<Product> products,
    required String paymentMethod,
    required double totalPrice,
  }) async {
    final token = await SharedPrefsHelper.getToken();

    try {
      final orderData = {
        "products":
            products
                .map((p) => {"productId": p.id, "quantity": p.quantity})
                .toList(),
        "paymentMethod": paymentMethod,
        "totalPrice": totalPrice,
      };

      await DioHelper.postData(
        url: "http://192.168.1.7:3000/orders",
        data: orderData,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return true;
    } catch (e) {
      log("Failed to create order: $e");
      return false;
    }
  }
}
