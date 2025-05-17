import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/data/models/subcategory_model.dart';
import 'package:furni_iti/features/shop/data/repositories/subcategory_repository.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/custom_tab_bar.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/products_grid_view.dart';

class SubcategoriesScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const SubcategoriesScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  List<SubcategoryModel> subcategories = [];
  Map<String, List<Product>> allProductsMap = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final repo = SubcategoryProductsRepository();
    await DioHelper.setTokenHeader();

    final allSubs = await repo.fetchAllSubcategories();

    subcategories =
        allSubs.where((sub) => sub.categoryId == widget.categoryId).toList();

    for (var sub in subcategories) {
      log('Loading products for subcategory ID: ${sub.id}');
      final products = await repo.fetchProducts(sub.id);
      allProductsMap[sub.id] = products;
      log('Loaded ${products.length} products for ${sub.name}');
    }

    _tabController = TabController(length: subcategories.length, vsync: this);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        bottom:
            isLoading || subcategories.isEmpty
                ? null
                : CustomTabBar(
                  controller: _tabController!,
                  labels: subcategories.map((e) => e.name).toList(),
                ),
                

      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : subcategories.isEmpty
              ? const Center(child: Text("No subcategories"))
              : TabBarView(
                controller: _tabController,
                children:
                    subcategories.map((sub) {
                      final list = allProductsMap[sub.id] ?? [];

                      if (list.isEmpty) {
                        return const Center(child: Text("No products"));
                      }

                      return ProductsGridView(products: list);
                    }).toList(),
              ),
    );
  }
}
