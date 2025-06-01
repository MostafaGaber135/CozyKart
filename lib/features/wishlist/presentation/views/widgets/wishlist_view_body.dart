import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/generated/l10n.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  List<Product> _wishlist = [];

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    final list = await WishlistService().getWishlist();
    setState(() {
      _wishlist = list;
    });
  }

  void _removeItem(Product product) async {
    await WishlistService().removeFromWishlist(product);
    _loadWishlist();
    if (!mounted) return;
    showToast(S.of(context).removedFromWishlist, isError: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        children: [
          Expanded(
            child:
                _wishlist.isEmpty
                    ? Center(
                      child: Text(
                        S.of(context).wishlistEmpty,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _wishlist.length,
                      itemBuilder: (context, index) {
                        final product = _wishlist[index];
                        return _WishlistItem(
                          product: product,
                          onRemove: () => _removeItem(product),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

class _WishlistItem extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const _WishlistItem({required this.product, required this.onRemove});

  Future<void> addToCart(BuildContext context, Product product) async {
    try {
      await CartService().addToCart(product.id);
      if (!context.mounted) return;
      showToast(S.of(context).addedToCart);
    } catch (e) {
      showToast("Error adding to cart", isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.localizedName(context),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${product.price.toStringAsFixed(2)} USD',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: S.of(context).addToCart,
                      onPressed: () => addToCart(context, product),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
