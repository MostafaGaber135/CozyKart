import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

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

  Future<void> addToWishlist(BuildContext context) async {
    final wishlist = await WishlistService.getWishlist();
    final alreadyExists = wishlist.any((item) => item.id == product.id);
    if (!alreadyExists) {
      final fixedProduct = Product(
        id: product.id,
        name: product.name,
        price: product.price,
        image: product.image,
      );
      await WishlistService.addToWishlist(fixedProduct);

      _showToast("Added to Wishlist");
    } else {
      _showToast("Already in Wishlist", isError: true);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => addToWishlist(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: product.image,
              height: 250,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.price.toStringAsFixed(2)} EGP',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
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
        padding: const EdgeInsets.all(16.0),

        child: PrimaryButton(
          title: 'Add to Cart',
          onPressed: () => addToCart(context as Product),
        ),
      ),
    );
  }
}
