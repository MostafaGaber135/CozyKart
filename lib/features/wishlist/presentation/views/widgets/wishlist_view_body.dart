import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_details_screen.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';

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

    log("Wishlist loaded in UI: ${data.length}");
    for (var item in data) {
      log("${item.name} | ${item.price} | ${item.image}");
    }

    setState(() {
      wishlist = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return wishlist.isEmpty
        ? const Center(child: Text("Your wishlist is empty"))
        : ListView.builder(
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final product = wishlist[index];
            return ListTile(
              leading: CachedNetworkImage(
                imageUrl: product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product.name),
              subtitle: Text("Price: EGP ${product.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await WishlistService.removeFromWishlist(product.id);
                  loadWishlist();
                  showToast('Removed from wishlist');
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(product: product),
                  ),
                );
              },
            );
          },
        );
  }
}
