import 'package:furni_iti/features/shop/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}