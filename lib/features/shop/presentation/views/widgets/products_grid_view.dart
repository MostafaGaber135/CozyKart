import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_details_view.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/generated/l10n.dart';

class ProductsGridView extends StatefulWidget {
  final List<Product> products;
  const ProductsGridView({super.key, required this.products});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  Set<String> wishlistIds = {};
  Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();
    loadWishlist();
    for (var product in widget.products) {
      quantities[product.id] = 1; // default quantity = 1
    }
  }

  Future<void> loadWishlist() async {
    final wishlist = await WishlistService().getWishlist();
    setState(() {
      wishlistIds = wishlist.map((e) => e['_id'].toString()).toSet();
    });
  }

  Future<void> addToCart(Product product) async {
    try {
      final token = await SharedPrefsHelper.getToken();
      final userId = await SharedPrefsHelper.getUserId();
      final quantity = quantities[product.id] ?? 1;

      final response = await Dio().post(
        'https://furniture-nodejs-production-665a.up.railway.app/carts',
        data: {
          "userId": userId,
          "productId": product.id,
          "quantity": quantity,
          "priceAtAddition": product.price,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast(S.of(context).addedToCart);
      } else {
        showToast(S.of(context).alreadyInCart, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      showToast(S.of(context).alreadyInCart, isError: true);
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
        childAspectRatio: 0.56,
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
                        height: 101.h,
                        width: double.infinity,
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
                            final isInWishlist = wishlistIds.contains(
                              product.id,
                            );
                            setState(() {
                              if (isInWishlist) {
                                wishlistIds.remove(product.id);
                              } else {
                                wishlistIds.add(product.id);
                              }
                            });

                            await WishlistService().toggleWishlist(product.id);

                            if (!context.mounted) return;
                            if (isInWishlist) {
                              showToast(
                                S.of(context).removedFromWishlist,
                                isError: true,
                              );
                            } else {
                              showToast(S.of(context).addedToWishlist);
                            }
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
                    '${product.price.toStringAsFixed(2)} EGP',
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
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '${quantities[product.id] ?? 1}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            final current = quantities[product.id] ?? 1;
                            quantities[product.id] = current + 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 10.w, right: 10),
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
