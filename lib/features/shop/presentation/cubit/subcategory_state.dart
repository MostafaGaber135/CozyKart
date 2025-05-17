import 'package:furni_iti/features/shop/data/models/product_model.dart';

abstract class SubcategoryProductsState {}

class SubcategoryProductsInitial extends SubcategoryProductsState {}

class SubcategoryProductsLoading extends SubcategoryProductsState {}

class SubcategoryProductsLoaded extends SubcategoryProductsState {
  final List<Product> products;

  SubcategoryProductsLoaded(this.products);
}

class SubcategoryProductsError extends SubcategoryProductsState {
  final String message;

  SubcategoryProductsError(this.message);
}
