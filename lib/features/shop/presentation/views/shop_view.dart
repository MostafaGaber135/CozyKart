import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/features/shop/data/datasources/category_remote_datasource.dart';
import 'package:furni_iti/features/shop/data/repositories/category_repository_impl.dart';
import 'package:furni_iti/features/shop/domain/usecases/get_categories.dart';
import 'package:furni_iti/features/shop/presentation/cubit/category_cubit.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/shop_view_body.dart';

class ShopView extends StatelessWidget {
  static const String routeName = '/shop';

  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final remoteDataSource = CategoryRemoteDataSource(DioHelper.dio);
        final repository = CategoryRepositoryImpl(remoteDataSource);
        final getCategories = GetCategories(repository);
        return CategoryCubit(getCategories)..fetchCategories();
      },
      child: const Scaffold(body: SafeArea(child: ShopViewBody())),
    );
  }
}
