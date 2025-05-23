import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/core/utils/toast_helper.dart';
import 'package:cozykart/core/widgets/primary_button.dart';
import 'package:cozykart/features/cart/presentation/views/widgets/cart_item_widget.dart';
import 'package:cozykart/features/payment/presentation/views/widgets/paypal_webview.dart';
import 'package:cozykart/features/shop/data/models/product_model.dart';
import 'package:cozykart/core/services/paypal_service.dart';
import 'package:cozykart/generated/l10n.dart';

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
    setState(() {
      cartItems = items;
    });
  }

  Future<void> startPayPalCheckout() async {
    final token = await PayPalService.getAccessToken();
    if (token == null || !mounted) return;

    final total = cartItems.fold<double>(
      0.0,
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
        ? Center(child: Text(S.of(context).cartEmpty))
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
                      title: item.localizedName(context),
                      subtitle: "EGP ${item.price.toStringAsFixed(2)}",
                      imageUrl: item.image,
                      quantity: item.quantity,
                      onRemove: () async {
                        await SharedPrefsHelper.removeFromCart(item.id);
                        loadCart();
                        if (!context.mounted) return;
                        showToast(S.of(context).removedFromCart, isError: true);
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
                    "${S.of(context).total}: EGP ${cartItems.fold<double>(0.0, (sum, item) => sum + (item.price * item.quantity)).toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity.w,
                    child: PrimaryButton(
                      onPressed: startPayPalCheckout,
                      title: S.of(context).checkoutWithPayPal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
  }
}
