import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/data/repositories/subcategory_repository.dart';
import 'package:furni_iti/features/shop/presentation/cubit/subcategory_state.dart';

class SubcategoryProductsCubit extends Cubit<SubcategoryProductsState> {
  final SubcategoryProductsRepository repository;

  SubcategoryProductsCubit(this.repository)
      : super(SubcategoryProductsInitial());

  void getProductsByCategory(String categoryId) async {
    emit(SubcategoryProductsLoading());
    try {
      final products = await repository.fetchProductsByCategory(categoryId);
      emit(SubcategoryProductsLoaded(products));
    } catch (e) {
      emit(SubcategoryProductsError(e.toString()));
    }
  }
}
