import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/cart/presentation/views/widgets/cart_item_widget.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

import 'package:furni_iti/core/services/paypal_service.dart';
import 'package:furni_iti/features/payment/presentation/views/widgets/paypal_webview.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> with RouteAware {
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCart();
  }

  Future<void> loadCart() async {
    final items = await SharedPrefsHelper.getCart();
    log("LOADED CART ITEMS: ${items.length}");

    for (var item in items) {
      log(" Name: ${item.name}");
      log("Image: ${item.image}");
      log("Price: ${item.price}");
    }

    setState(() {
      cartItems = items;
    });
  }

  Future<void> startPayPalCheckout() async {
    final token = await PayPalService.getAccessToken();
    if (token == null || !mounted) return;

    final total = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );

    final orderId = await PayPalService.createOrder(
      token,
      total.toStringAsFixed(2),
    );
    if (orderId == null || !mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => PaypalWebView(
              checkoutUrl:
                  "https://www.sandbox.paypal.com/checkoutnow?token=$orderId",
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cartItems.isEmpty
        ? const Center(child: Text("Your cart is empty"))
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CartItemWidget(
                      title: item.name,
                      subtitle: "EGP ${item.price.toStringAsFixed(2)}",
                      imageUrl: item.image,
                      quantity: item.quantity,
                      onRemove: () async {
                        await SharedPrefsHelper.removeFromCart(item.id);
                        loadCart();
                        showToast("Removed from cart");
                      },
                      onIncrement: () {
                        setState(() {
                          item.quantity++;
                        });
                        SharedPrefsHelper.saveCart(cartItems);
                      },
                      onDecrement: () {
                        if (item.quantity > 1) {
                          setState(() {
                            item.quantity--;
                          });
                          SharedPrefsHelper.saveCart(cartItems);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
              child: Column(
                children: [
                  Text(
                    "Total: EGP ${cartItems.fold<double>(0, (sum, item) => sum + (item.price * item.quantity)).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: (double.infinity).w,
                    child: PrimaryButton(
                      onPressed: startPayPalCheckout,
                      title: "Checkout with PayPal",
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
