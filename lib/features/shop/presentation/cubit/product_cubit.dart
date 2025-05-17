import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/data/repositories/product_repository.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_state.dart';

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
}
