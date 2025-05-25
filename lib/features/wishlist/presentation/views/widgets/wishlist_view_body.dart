import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  List<dynamic> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    try {
      final items = await WishlistService().getWishlist();
      setState(() {
        wishlistItems = items;
      });
    } catch (e) {
      log('Error loading wishlist: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final item = wishlistItems[index];
        return ListTile(
          title: Text(item['name']['en'] ?? 'No Name'),
          subtitle: Text('Price: \$${item['price']}'),
        );
      },
    );
  }
}
