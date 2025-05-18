import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWebView extends StatefulWidget {
  final String checkoutUrl;
  const PaypalWebView({super.key, required this.checkoutUrl});

  @override
  State<PaypalWebView> createState() => _PaypalWebViewState();
}

class _PaypalWebViewState extends State<PaypalWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                debugPrint("Navigating to: $url");
                if (url.contains("sandbox.paypal.com/checkoutnow")) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("🔐 Opened PayPal Sandbox Checkout"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              onPageFinished: (url) {
                debugPrint("Page loaded: $url");
              },
              onWebResourceError: (error) {
                debugPrint("WebView Error: ${error.description}");
              },
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text("PayPal Checkout"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
