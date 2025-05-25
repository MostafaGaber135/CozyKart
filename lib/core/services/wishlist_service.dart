import 'dart:developer';

import '../../core/network/dio_helper.dart';
import 'shared_prefs_helper.dart';

class WishlistService {
  Future<void> toggleWishlist(String productId) async {
    final token = await SharedPrefsHelper.getToken();
    final response = await DioHelper.postData(
      url: 'wishlist/toggle',
      data: {'productId': productId},
      headers: {'Authorization': 'Bearer $token'},
    );
    log('WISHLIST TOGGLE RESPONSE: ${response.data}');
  }

  Future<List<dynamic>> getWishlist() async {
    final token = await SharedPrefsHelper.getToken();
    final response = await DioHelper.getData(
      url: 'wishlist',
      headers: {'Authorization': 'Bearer $token'},
    );
    log('GET WISHLIST RESPONSE: ${response.data}');
    return response.data['wishlist'] ?? [];
  }
}
