import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_cubit.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_state.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/products_grid_view.dart';

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
              .where((product) => product.name.toLowerCase().contains(query))
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
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Product Grid
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
                              (p) => p.name.toLowerCase().contains(
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
