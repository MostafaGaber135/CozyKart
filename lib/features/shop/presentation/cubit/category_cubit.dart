
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/domain/entities/category.dart';
import 'package:furni_iti/features/shop/domain/usecases/get_categories.dart';
import 'package:furni_iti/features/shop/presentation/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories getCategoriesUseCase;
  List<Category> _allCategories = [];

  CategoryCubit(this.getCategoriesUseCase) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await getCategoriesUseCase();
      _allCategories = categories;
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  void searchCategories(String query) {
    if (state is CategoryLoaded) {
      if (query.isEmpty) {
        emit(CategoryLoaded(_allCategories));
      } else {
        final filtered = _allCategories
            .where((category) => category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(CategoryLoaded(_allCategories, filtered));
      }
    }
  }
}
