import 'package:dio/dio.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class ProductRepository {
  final Dio _dio = DioHelper.dio;

  Future<List<Product>> fetchProducts() async {
    try {
      await DioHelper.setTokenHeader();

      final response = await _dio.get("products");

      if (response.statusCode == 200) {
        List productsJson = response.data['products'];
        return productsJson.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
