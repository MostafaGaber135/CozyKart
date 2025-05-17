import 'package:furni_iti/features/shop/domain/entities/category.dart';
import 'package:furni_iti/features/shop/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<List<Category>> call() async {
    return await repository.getCategories();
  }
}