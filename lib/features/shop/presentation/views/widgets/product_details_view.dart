import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/generated/l10n.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final WishlistService _wishlistService = WishlistService();

  Future<void> addToCart(Product product) async {
    if (product.inStock == 0) {
      showToast("This product is out of stock", isError: true);
      return;
    }

    try {
      await CartService().addToCart(product.id);
      if (!mounted) return;
      showToast(S.of(context).addedToCart);
    } catch (e) {
      log("Error adding to cart: $e");
      showToast("Error adding to cart", isError: true);
    }
  }

  void _toggleWishlist() {
    setState(() {
      _wishlistService.toggleWishlist(widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.localizedName(context)),
        actions: [
          FutureBuilder<bool>(
            future: _wishlistService.isInWishlist(product),
            builder: (context, snapshot) {
              final isWishlisted = snapshot.data ?? false;
              return IconButton(
                icon: Icon(
                  isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: isWishlisted ? Colors.red : null,
                ),
                onPressed: _toggleWishlist,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              height: 250.h,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.localizedName(context),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${product.price.toStringAsFixed(2)} ${S.of(context).usd}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h),
                  Text(product.localizedDescription(context)),
                  SizedBox(height: 24.h),
                  PrimaryButton(
                    title: S.of(context).addToCart,
                    onPressed: () => addToCart(product),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
