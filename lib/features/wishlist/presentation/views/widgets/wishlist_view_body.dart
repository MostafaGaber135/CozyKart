import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/utils/toast_helper.dart';
import 'package:cozykart/features/shop/data/models/product_model.dart';
import 'package:cozykart/features/shop/presentation/views/widgets/product_details_view.dart';
import 'package:cozykart/core/services/wishlist_service.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/generated/l10n.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  List<Product> wishlist = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadWishlist());
  }

  Future<void> loadWishlist() async {
    final data = await WishlistService.getWishlist();
    log("Wishlist loaded: ${data.length}");

    setState(() {
      wishlist = data;
    });
  }

  Future<void> addToCart(Product product) async {
    final cart = await SharedPrefsHelper.getCart();
    final exists = cart.any((item) => item.id == product.id);

    if (!exists) {
      cart.add(product);
      await SharedPrefsHelper.saveCart(cart);
      if (!mounted) return;
      showToast(S.of(context).addedToCart);
    } else {
      if (!mounted) return;
      showToast(S.of(context).alreadyInCart, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return wishlist.isEmpty
        ? Center(
          child: Text(
            S.of(context).wishlistEmpty,
            style: TextStyle(fontSize: 18, color: theme.primaryColor),
          ),
        )
        : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlist[index];

            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: Offset(0.w, 4.h),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsView(product: product),
                      ),
                    ),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          height: 100.h,
                          width: 100.w,
                          fit: BoxFit.cover,
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

                      SizedBox(width: 14.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.localizedName(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              "EGP ${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () => addToCart(product),
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 18.sp,
                                    ),
                                    label: Text(S.of(context).addToCart),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.w,
                                      ),
                                      backgroundColor: theme.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await WishlistService.removeFromWishlist(
                                      product.id,
                                    );
                                    await loadWishlist();
                                    if (!context.mounted) return;
                                    showToast(
                                      S.of(context).removedFromWishlist,
                                      isError: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
