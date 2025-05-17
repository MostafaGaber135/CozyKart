import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_cubit.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_state.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/custom_product.dart';

class ProductsTabPage extends StatelessWidget {
  const ProductsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.blueAccent,
            ),
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            AllProductsTab(),
            FavoritesProductsTab(),
          ],
        ),
      ),
    );
  }
}

class AllProductsTab extends StatelessWidget {
  const AllProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const ProductShimmer();
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: 1,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('${product.price.toStringAsFixed(0)} EGP'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class FavoritesProductsTab extends StatelessWidget {
  const FavoritesProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favorites Coming Soon'));
  }
}
