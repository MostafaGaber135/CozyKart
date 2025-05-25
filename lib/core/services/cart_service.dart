import 'dart:developer';

import 'package:dio/dio.dart';
import '../../core/network/dio_helper.dart';
import 'shared_prefs_helper.dart';

class CartService {
  Future<void> addToCart(String productId, {int quantity = 1}) async {
    final token = await SharedPrefsHelper.getToken();
    final response = await DioHelper.postData(
      url: 'carts',
      data: {"productId": productId, "quantity": quantity},
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("ADD TO CART RESPONSE => ${response.data}");
    } else {
      log("Failed to add to cart: ${response.statusCode} | ${response.data}");
    }
  }

  Future<void> removeFromCart(String productId) async {
    final token = await SharedPrefsHelper.getToken();
    await DioHelper.deleteData(
      url: 'carts/$productId',
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final token = await SharedPrefsHelper.getToken();
    await DioHelper.patchData(
      url: 'carts/$productId',
      data: {"quantity": quantity},
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<List<dynamic>> getCart() async {
    final token = await SharedPrefsHelper.getToken();

    final response = await Dio().get(
      'https://furniture-nodejs-production-665a.up.railway.app/carts',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    log("RESPONSE TYPE => ${response.data.runtimeType}");
    log("RESPONSE => ${response.data}");

    if (response.statusCode == 200) {
      final rawData = response.data;

      if (rawData is Map) {
        final possibleKeys = ['data', 'cart', 'carts', 'result'];
        for (var key in possibleKeys) {
          if (rawData.containsKey(key) && rawData[key] is List) {
            final allItems = rawData[key] as List;
            return allItems.map((item) {
              item['product'] = item['productId'];
              return item;
            }).toList();
          }
        }
        throw Exception('Expected a list inside response map but none found');
      }

      if (response.data is List) {
        final allItems = response.data as List;
        return allItems.map((item) {
          item['product'] = item['productId'];
          return item;
        }).toList();
      }

      throw Exception('Unexpected response format');
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
