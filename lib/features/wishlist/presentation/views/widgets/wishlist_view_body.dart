import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_details_view.dart';
import 'package:furni_iti/core/services/wishlist_service.dart';

class WishlistViewBody extends StatefulWidget {
  const WishlistViewBody({super.key});

  @override
  State<WishlistViewBody> createState() => _WishlistViewBodyState();
}

class _WishlistViewBodyState extends State<WishlistViewBody> {
  List<Product> wishlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadWishlist());
  }

  Future<void> loadWishlist() async {
    setState(() => isLoading = true);
    wishlist = await WishlistService.getWishlist();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (wishlist.isEmpty) {
      return const Center(child: Text("Your wishlist is empty"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wishlist.length,
      itemBuilder: (context, index) {
        final product = wishlist[index];
        return Card(
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: product.image,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
            ),
            title: Text(product.localizedName(context)),
            subtitle: Text(product.localizedDescription(context)),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final success = await WishlistService.removeFromWishlist(
                  product.id,
                );
                if (!mounted) return;
                if (success) {
                  Fluttertoast.showToast(msg: "Removed from wishlist");
                  loadWishlist();
                } else {
                  Fluttertoast.showToast(msg: "Error occurred");
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsView(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
