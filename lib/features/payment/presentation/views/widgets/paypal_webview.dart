import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              onNavigationRequest: (request) {
                final url = request.url;
                debugPrint("➡️ Navigating to: $url");
                if (!_hasRedirected &&
                    (url.contains("/review") ||
                        url.contains("/checkout/complete") ||
                        url.contains("PayerID="))) {
                  _hasRedirected = true;
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    backgroundColor: Colors.green,
                    msg: "Checkout completed successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  return NavigationDecision.prevent;
                }

                if (url.contains("cancel") ||
                    url.contains("paypal.com/cancel")) {
                  _hasRedirected = true;
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    backgroundColor: Colors.red,
                    msg: "Checkout cancelled",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
              onWebResourceError:
                  (error) => debugPrint("WebView error: ${error.description}"),
            ),
          );

    Future.delayed(const Duration(milliseconds: 100), () {
      _controller.loadRequest(Uri.parse(widget.checkoutUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "PayPal Checkout",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
