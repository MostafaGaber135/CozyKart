import 'package:furni_iti/features/shop/domain/entities/category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final List<Category> filteredCategories;

  CategoryLoaded(this.categories, [List<Category>? filtered])
    : filteredCategories = filtered ?? categories;
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
