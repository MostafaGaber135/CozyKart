import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/network/dio_helper.dart';

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
              onNavigationRequest: (request) async {
                final url = request.url;
                log("Navigating to: $url");
                if (!_hasRedirected && url.contains("PayerID=")) {
                  _hasRedirected = true;
                  log("READY TO POST ORDER TO BACKEND");

                  try {
                    final userId = await SharedPrefsHelper.getUserId();
                    final token = await SharedPrefsHelper.getToken();
                    await syncCartToBackend();
                    final shippingAddress = {
                      "fullName": "John Doe",
                      "street": "123 Main St",
                      "country": "US",
                      "city": "San Jose",
                      "state": "CA",
                      "postalCode": "95131",
                      "phone": "+11234567890",
                    };
                    final cartItems = await SharedPrefsHelper.getCart();
                    final products =
                        cartItems
                            .map(
                              (item) => {
                                "productId": item.id,
                                "quantity": item.quantity,
                              },
                            )
                            .toList();
                    final orderPayload = {
                      "userId": userId,
                      "products": products,
                      "shippingAddress": shippingAddress,
                      "paymentMethod": "paypal",
                    };
                    log("Order payload: $orderPayload");
                    await DioHelper.postData(
                      url:
                          "https://furniture-nodejs-production-665a.up.railway.app/orders",
                      data: orderPayload,
                      headers: {
                        "Authorization": "Bearer $token",
                        "Content-Type": "application/json",
                      },
                    );
                    log("Order sent successfully!");
                    if (!mounted) return NavigationDecision.prevent;
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      backgroundColor: Colors.green,
                      msg: "Checkout completed successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } catch (e) {
                    log("Failed to send order: $e");
                    Fluttertoast.showToast(
                      backgroundColor: Colors.red,
                      msg: "Something went wrong while sending the order",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                    );
                  }
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("PayPal Checkout"),
        backgroundColor: settingsProvider.isDark ? Colors.black : Colors.white,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
