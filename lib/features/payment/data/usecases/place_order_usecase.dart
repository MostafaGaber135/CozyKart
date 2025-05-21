import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:furni_iti/core/network/dio_helper.dart';

class PlaceOrderUseCase {
  Future<void> call({
    required String userId,
    required List<Map<String, dynamic>> products,
    required double total,
  }) async {
    final payload = {
      "userId": userId,
      "products": products,
      "total": total,
      "paymentMethod": "paypal",
    };

    try {
      log("Sending Order Payload:");
      log(jsonEncode(payload));

      final response = await DioHelper.dio.post("/orders", data: payload);

      log("Order placed: ${response.data}");
    } on DioException catch (e) {
      log("Order API Error:");
      log("Status: ${e.response?.statusCode}");
      log("Data: ${e.response?.data.toString()}");
      rethrow;
    } catch (e) {
      log("Unexpected Error: $e");
      rethrow;
    }
  }
}
