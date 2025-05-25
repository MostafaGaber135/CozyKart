import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/cart/presentation/views/widgets/cart_item_widget.dart';
import 'package:furni_iti/features/payment/presentation/views/widgets/paypal_webview.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> with RouteAware {
  List<Product> cartItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    setState(() => isLoading = true);
    cartItems = await CartService.getCart();
    setState(() => isLoading = false);
  }

  double calculateTotalPrice() {
    return cartItems.fold(
      0.0,
      (total, item) => total + item.price * (item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cartItems.isEmpty) {
      return const Center(child: Text("Your cart is empty"));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return CartItemWidget(
                product: product,
                onRemove: () async {
                  final success = await CartService.removeFromCart(product.id);
                  if (!mounted) return;
                  if (success) {
                    Fluttertoast.showToast(msg: "Removed from cart");
                    loadCart();
                  } else {
                    Fluttertoast.showToast(msg: "Failed to remove");
                  }
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            title: "Checkout \$${calculateTotalPrice().toStringAsFixed(2)}",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => const PaypalWebView(
                        checkoutUrl: "https://example.com/success",
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
