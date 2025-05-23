import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cozykart/features/shop/data/repositories/product_repository.dart';
import 'package:cozykart/features/shop/presentation/cubit/product_cubit.dart';
import 'package:cozykart/features/shop/presentation/views/widgets/shop_view_body.dart';

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
