import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_cubit.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_state.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/products_grid_view.dart';
import 'package:furni_iti/generated/l10n.dart';

class ShopProductsViewBody extends StatefulWidget {
  const ShopProductsViewBody({super.key});

  @override
  State<ShopProductsViewBody> createState() => _ShopProductsViewBodyState();
}

class _ShopProductsViewBodyState extends State<ShopProductsViewBody> {
  TextEditingController searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    context.read<ProductCubit>().getProducts();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =
          _allProducts
              .where(
                (product) => product
                    .localizedName(context)
                    .toLowerCase()
                    .contains(query),
              )
              .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: S.of(context).searchProducts,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
              iconColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        Expanded(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                _allProducts = state.products;
                _filteredProducts =
                    searchController.text.isEmpty
                        ? _allProducts
                        : _allProducts
                            .where(
                              (p) => p
                                  .localizedName(context)
                                  .toLowerCase()
                                  .contains(
                                    searchController.text.toLowerCase(),
                                  ),
                            )
                            .toList();

                return ProductsGridView(products: _filteredProducts);
              } else if (state is ProductError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
