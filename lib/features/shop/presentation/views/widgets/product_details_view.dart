import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

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
      _showToast("Removed from Wishlist");
    } else {
      await WishlistService.addToWishlist(widget.product);
      setState(() => isWishlisted = true);
      _showToast("Added to Wishlist");
    }
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
        title: Text(product.name),
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
                    product.name,
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
                    'Description:',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const Text(
                    'This is a high quality product perfect for your home or office.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.r),
        child: PrimaryButton(
          title: 'Add to Cart',
          onPressed: () => addToCart(product),
        ),
      ),
    );
  }
}
