import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cozykart/features/shop/data/repositories/product_repository.dart';
import 'package:cozykart/features/shop/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  void getProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void getBestPriceProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();

      final sorted =
          products.toList()..sort((a, b) => a.price.compareTo(b.price));

      final bestFour = sorted.take(4).toList();
      emit(BestPriceProductsLoaded(bestFour));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
