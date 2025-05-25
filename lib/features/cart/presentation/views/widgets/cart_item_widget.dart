import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = product.quantity;
    final total = (product.price * quantity).toStringAsFixed(2);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: product.image,
            width: 80.w,
            height: 80.h,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.localizedName(context),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.h),
                Text(
                  product.localizedDescription(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Qty: $quantity × ${product.price.toStringAsFixed(2)} = $total EGP",
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
