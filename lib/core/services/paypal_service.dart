import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class PayPalService {
  static const String clientId =
      "AYSDaD8ZjfGIQ2w04v3OtLXP6VtsH2CklFd6zJGhY2zc0OdeG--3H78jGCBn_9zhyvXvS54mkurQIzmi";
  static const String secret =
      "ECnQhOKy4U5jVJM3rB9HrXfGO-Nr8kqSTq8F6P-LcxobtY7BxYEJBIzDOraYKn7e78wkNukORBJPz8Oe";
  static const String domain = "https://api.sandbox.paypal.com"; 

  static final Dio _dio = Dio();

  static Future<String?> getAccessToken() async {
    final basicAuth = base64Encode(utf8.encode('$clientId:$secret'));

    try {
      final response = await _dio.post(
        "$domain/v1/oauth2/token",
        options: Options(
          headers: {
            'Authorization': 'Basic $basicAuth',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {'grant_type': 'client_credentials'},
      );

      return response.data['access_token'];
    } catch (e) {
      log("Failed to get token: $e");
      return null;
    }
  }

  static Future<String?> createOrder(String accessToken, String amount) async {
    try {
      final response = await _dio.post(
        "$domain/v2/checkout/orders",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "intent": "CAPTURE",
          "purchase_units": [
            {
              "amount": {
                "currency_code": "USD",
                "value": amount,
              },
            }
          ],
          "application_context": {
            "return_url": "https://example.com/success", 
            "cancel_url": "https://example.com/cancel"
          }
        },
      );

      return response.data['id'];
    } catch (e) {
      log("Failed to create order: $e");
      return null;
    }
  }
}
