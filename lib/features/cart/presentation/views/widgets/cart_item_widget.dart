import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/generated/l10n.dart';

class CartItemWidget extends StatefulWidget {
  final Product product;
  final VoidCallback onRemove;
  final Function(int) onQuantityChange;

  const CartItemWidget({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onQuantityChange,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.product.quantity;
  }

  void increment() {
    setState(() => quantity++);
    widget.onQuantityChange(quantity);
  }

  void decrement() {
    if (quantity > 1) {
      setState(() => quantity--);
      widget.onQuantityChange(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = (widget.product.price * quantity).toStringAsFixed(2);

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
            imageUrl: widget.product.image,
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
                  widget.product.localizedName(context),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.product.localizedDescription(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13.sp, color: Colors.black),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    IconButton(
                      onPressed: decrement,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '$quantity',
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: increment,
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${S.of(context).quantity}: $quantity",
                  style: TextStyle(fontSize: 13.sp, color: Colors.black),
                ),
                Text(
                  "${S.of(context).total}: $total ${S.of(context).usd}",
                  style: TextStyle(fontSize: 13.sp, color: Colors.black),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
