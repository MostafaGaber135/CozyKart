import 'package:dio/dio.dart';
import 'package:furni_iti/features/shop/data/models/category_model.dart';

class CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSource(this.dio);

  Future<List<CategoryModel>> fetchCategories() async {
    final response = await dio.get(
      'https://furniture-backend-production-8726.up.railway.app/categories',
    );

    if (response.statusCode == 200) {
      List categories = response.data['categories'];
      return categories.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
