import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_details_view.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> products;
  const ProductsGridView({super.key, required this.products});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  Set<String> wishlistIds = {};

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    final wishlist = await WishlistService.getWishlist();
    setState(() {
      wishlistIds = wishlist.map((e) => e.id).toSet();
    });
  }

  Future<void> addToCart(Product product) async {
    final cart = await SharedPrefsHelper.getCart();
    final exists = cart.any((item) => item.id == product.id);

    if (!exists) {
      cart.add(product);
      await SharedPrefsHelper.saveCart(cart);
      showToast("Added to cart");
    } else {
      showToast("Already in cart", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.68,
      ),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        final product = widget.products[index];
        final isWishlisted = wishlistIds.contains(product.id);

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
                  offset: Offset(0.w, 4.h),
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
                        height: 100.h,
                        width: (double.infinity).w,
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                              ),
                            ),
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
                              offset: Offset(0.w, 2.h),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                            size: 22.sp,
                          ),
                          onPressed: () async {
                            await WishlistService.addToWishlist(product);
                            await loadWishlist();
                            showToast('Added to wishlist');
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
                    product.name,
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
                    '${product.price.toStringAsFixed(2)} EGP',
                    style: const TextStyle(color: AppColors.darkBackground),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 10.w),
                  child: PrimaryButton(
                    title: 'Add To Cart',
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
