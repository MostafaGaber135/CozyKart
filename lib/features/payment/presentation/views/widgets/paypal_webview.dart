import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/services/order_service.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWebView extends StatefulWidget {
  final String checkoutUrl;
  const PaypalWebView({super.key, required this.checkoutUrl});

  @override
  State<PaypalWebView> createState() => _PaypalWebViewState();
}

class _PaypalWebViewState extends State<PaypalWebView> {
  late final WebViewController _controller;
  bool _hasRedirected = false;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                if (!_hasRedirected && url.contains('success')) {
                  _hasRedirected = true;
                  await _handleSuccessfulPayment();
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  Future<void> _handleSuccessfulPayment() async {
    Fluttertoast.showToast(msg: "Payment successful. Creating order...");

    final cartItemsRaw = await CartService().getCart();
    final List<Product> cartItems =
        cartItemsRaw.map((e) => Product.fromJson(e['product'])).toList();

    final totalPrice = cartItems.fold(0.0, (total, item) {
      return total + item.price * (item.quantity);
    });

    final success = await OrderService.createOrder(
      products: cartItems,
      paymentMethod: "PayPal",
      totalPrice: totalPrice,
    );

    if (!mounted) return;

    if (success) {
      Fluttertoast.showToast(msg: "Order placed successfully");
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      Fluttertoast.showToast(msg: "Failed to place order");
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
