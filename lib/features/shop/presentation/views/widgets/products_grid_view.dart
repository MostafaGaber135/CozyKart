import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_details_view.dart';
import 'package:furni_iti/generated/l10n.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> products;
  const ProductsGridView({super.key, required this.products});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  Map<String, int> quantities = {};
  final WishlistService _wishlistService = WishlistService();

  Future<void> addToCart(Product product) async {
    final quantity = quantities[product.id] ?? 1;
    try {
      await CartService().addToCart(product.id, quantity: quantity);
      if (!mounted) return;
      showToast(S.of(context).addedToCart);
    } catch (e) {
      showToast("Error adding to cart", isError: true);
    }
  }

  void _toggleWishlist(Product product) async {
    await _wishlistService.toggleWishlist(product);
    final isNowInWishlist = await _wishlistService.isInWishlist(product);
    setState(() {});
    if (!mounted) return;
    showToast(
      isNowInWishlist
          ? S.of(context).addedToWishlist
          : S.of(context).removedFromWishlist,
      isError: !isNowInWishlist,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.56,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsView(product: product),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 8.r,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        height: 101.h,
                        width: double.infinity,
                        placeholder:
                            (context, url) =>
                                Center(child: CircularProgressIndicator()),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4.r,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: FutureBuilder<bool>(
                          future: _wishlistService.isInWishlist(product),
                          builder: (context, snapshot) {
                            final isWishlisted = snapshot.data ?? false;
                            return IconButton(
                              icon: Icon(
                                isWishlisted
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isWishlisted ? Colors.red : null,
                              ),
                              onPressed: () => _toggleWishlist(product),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  child: Text(
                    product.localizedName(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryAccent,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    '${product.price.toStringAsFixed(2)} ${S.of(context).egp}',
                    style: const TextStyle(color: AppColors.darkBackground),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final current = quantities[product.id] ?? 1;
                            if (current > 1) {
                              quantities[product.id] = current - 1;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                      Text(
                        '${quantities[product.id] ?? 1}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final current = quantities[product.id] ?? 1;
                            quantities[product.id] = current + 1;
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: AppColors.primaryAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: PrimaryButton(
                    title: S.of(context).addToCart,
                    onPressed: () => addToCart(product),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
