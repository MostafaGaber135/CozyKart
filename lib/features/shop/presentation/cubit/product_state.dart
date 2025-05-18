import 'package:furni_iti/features/shop/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class BestPriceProductsLoaded extends ProductState {
  final List<Product> bestPriceProducts;

  BestPriceProductsLoaded(this.bestPriceProducts);
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
