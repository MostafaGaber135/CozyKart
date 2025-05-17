import 'package:dio/dio.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/data/models/subcategory_model.dart';

class SubcategoryProductsRepository {
  final Dio dio;

  SubcategoryProductsRepository() : dio = DioHelper.dio;

  Future<List<Product>> fetchProducts(String subcategoryId) async {
    await DioHelper.setTokenHeader();

    final response = await dio.get(
      "https://furniture-backend-production-8726.up.railway.app/products",
      queryParameters: {"subcategory": subcategoryId},
    );

    if (response.statusCode == 200) {
      List productsJson = response.data['products'];
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products by subcategory');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    await DioHelper.setTokenHeader();

    final response = await dio.get(
      "https://furniture-backend-production-8726.up.railway.app/products",
      queryParameters: {"category": categoryId},
    );

    if (response.statusCode == 200) {
      List productsJson = response.data['products'];
      return productsJson.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  Future<List<SubcategoryModel>> fetchAllSubcategories() async {
    await DioHelper.setTokenHeader();

    final response = await dio.get(
      "https://furniture-backend-production-8726.up.railway.app/subcategories",
    );

    if (response.statusCode == 200) {
      List subsJson = response.data['subcategories'];
      return subsJson.map((e) => SubcategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}
