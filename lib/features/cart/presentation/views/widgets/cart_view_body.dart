import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'cart_item_widget.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  List<dynamic> cartItems = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    try {
      final items = await CartService().getCart();
      setState(() {
        cartItems = items;
        calculateTotal();
      });
    } catch (e) {
      log('Error loading cart: $e');
    }
  }

  void calculateTotal() {
    total = 0;
    for (var item in cartItems) {
      final price = item['priceAtAddition'] ?? 0;
      final quantity = item['quantity'] ?? 1;
      total += price * quantity;
    }
  }

  Future<void> deleteItem(String cartItemId) async {
    try {
      await CartService().removeFromCart(cartItemId);
      setState(() {
        cartItems.removeWhere((item) => item['_id'] == cartItemId);
        calculateTotal();
      });
    } catch (e) {
      log("Error deleting item: $e");
    }
  }

  Future<void> updateItemQuantity(String cartItemId, int quantity) async {
    await CartService().updateQuantity(cartItemId, quantity);
    await loadCart();
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Center(
        child: Text(
          "Your cart is empty 🛒",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final cartItemId = item['_id'];
              final productJson = item['product'];
              final quantity = item['quantity'] ?? 1;
              final product = Product.fromJson(productJson);
              product.quantity = quantity;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: CartItemWidget(
                  product: product,
                  onRemove: () => deleteItem(cartItemId),
                  onQuantityChange:
                      (newQty) => updateItemQuantity(cartItemId, newQty),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            "Total: ${total.toStringAsFixed(2)} EGP",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          PrimaryButton(title: 'Checkout', onPressed: () {}),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
