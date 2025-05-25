import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/data/repositories/product_repository.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_cubit.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/shop_view_body.dart';

class ShopView extends StatelessWidget {
  static const String routeName = '/shop';

  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(ProductRepository())..getProducts(),
      child: const Scaffold(body: SafeArea(child: ShopProductsViewBody())),
    );
  }
}
