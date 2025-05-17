import 'package:furni_iti/features/shop/data/datasources/category_remote_datasource.dart';
import 'package:furni_iti/features/shop/domain/entities/category.dart';
import 'package:furni_iti/features/shop/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    return (await remoteDataSource.fetchCategories())
        .map((e) => Category(
              id: e.id,
              name: e.name.en,
              image: e.image ?? '',
              subcategoriesId: e.subcategoriesId,
            ))
        .toList();
  }
}
