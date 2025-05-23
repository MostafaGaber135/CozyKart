import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/core/services/wishlist_service.dart';
import 'package:cozykart/core/utils/toast_helper.dart';
import 'package:cozykart/core/widgets/primary_button.dart';
import 'package:cozykart/features/shop/data/models/product_model.dart';
import 'package:cozykart/generated/l10n.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool isWishlisted = false;

  @override
  void initState() {
    super.initState();
    checkIfInWishlist();
  }

  Future<void> checkIfInWishlist() async {
    final wishlist = await WishlistService.getWishlist();
    setState(() {
      isWishlisted = wishlist.any((item) => item.id == widget.product.id);
    });
  }

  Future<void> toggleWishlist() async {
    final wishlist = await WishlistService.getWishlist();
    final alreadyExists = wishlist.any((item) => item.id == widget.product.id);

    if (alreadyExists) {
      await WishlistService.removeFromWishlist(widget.product.id);
      setState(() => isWishlisted = false);
      if (!mounted) return;
      _showToast(S.of(context).removedFromWishlist, isError: true);
    } else {
      await WishlistService.addToWishlist(widget.product);
      setState(() => isWishlisted = true);
      if (!mounted) return;
      _showToast(S.of(context).addedToWishlist);
    }
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

  void _showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.localizedName(context)),
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleWishlist,
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
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.localizedName(context),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${product.price.toStringAsFixed(2)} EGP',
                    style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    S.of(context).description,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(product.localizedDescription(context)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: PrimaryButton(
          title: S.of(context).addToCart,
          onPressed: () => addToCart(product),
        ),
      ),
    );
  }
}
